import os
import pg8000


def get_db_connection():
    """
    Open a new connection to the PostgreSQL database using environment variables.

    Env vars expected (set by Terraform in lambda.tf):
      - DB_HOST
      - DB_PORT
      - DB_NAME
      - DB_USER
      - DB_PASSWORD
    """
    host = os.environ.get("DB_HOST")
    port = int(os.environ.get("DB_PORT", "5432"))
    dbname = os.environ.get("DB_NAME")
    user = os.environ.get("DB_USER")
    password = os.environ.get("DB_PASSWORD")

    if not all([host, dbname, user, password]):
        raise RuntimeError("Database environment variables are not fully set.")

    conn = pg8000.connect(
        host=host,
        port=port,
        database=dbname,
        user=user,
        password=password,
    )
    return conn
