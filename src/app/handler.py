import json
from http import HTTPStatus
from .db import get_db_connection


def _response(status: int, body: dict):
    return {
        "statusCode": status,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps(body),
    }


def lambda_handler(event, context):
    """
    Entrypoint for AWS Lambda.

    Routes:
    - GET /health  -> basic health check + DB connectivity
    - GET /items   -> example SELECT from table 'items'
    """
    path = event.get("path", "/")
    http_method = event.get("httpMethod", "GET")

    if path.endswith("/health") and http_method == "GET":
        return health_check()
    elif path.endswith("/items") and http_method == "GET":
        return list_items()
    else:
        return _response(
            HTTPStatus.NOT_FOUND,
            {"message": f"Route {http_method} {path} not found"},
        )


def health_check():
    """Simple DB health check: run SELECT 1 and see if it works."""
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("SELECT 1;")
        row = cur.fetchone()
        cur.close()
        conn.close()

        ok = bool(row and row[0] == 1)

        return _response(
            HTTPStatus.OK,
            {"status": "ok", "db": ok},
        )
    except Exception as exc:
        return _response(
            HTTPStatus.INTERNAL_SERVER_ERROR,
            {"status": "error", "error": str(exc)},
        )


def list_items():
    """
    Example: list items from a simple table.

    The table is created if it does not exist:
      CREATE TABLE IF NOT EXISTS items (id serial PRIMARY KEY, name text);
    """
    try:
        conn = get_db_connection()
        cur = conn.cursor()

        # Ensure table exists (idempotent)
        cur.execute(
            "CREATE TABLE IF NOT EXISTS items (id serial PRIMARY KEY, name text);"
        )
        conn.commit()

        # Fetch rows
        cur.execute("SELECT id, name FROM items ORDER BY id ASC;")
        rows = cur.fetchall()
        cur.close()
        conn.close()

        # Convert tuple rows -> list of dicts for JSON response
        items = [{"id": r[0], "name": r[1]} for r in rows]

        return _response(HTTPStatus.OK, {"items": items})
    except Exception as exc:
        return _response(
            HTTPStatus.INTERNAL_SERVER_ERROR,
            {"status": "error", "error": str(exc)},
        )
