from dotenv import load_dotenv
from sqlalchemy import create_engine, text, inspect 
from utility import logger
import os 

load_dotenv()
LOCAL_STR_CONNECTION = os.getenv("DATABASE_URI_LOCAL_VER")
CLOUD_STR_CONNECTION = os.getenv("DATABASE_URI")

logger.info("Connecting to database (local)")
local_engine = create_engine(LOCAL_STR_CONNECTION)

logger.info("Connecting to database (cloud)")
cloud_engine = create_engine(CLOUD_STR_CONNECTION)

def give_read_access(engine, database_type):
    logger.info(f"Enabling RLS to the database ({database_type})")
    try:
        with engine.begin() as con: # Using engine.begin() automatically manages a transaction and commits on exit
            inspector = inspect(engine)
            
            # Restrict to the 'public' schema, which is what Supabase exposes by default
            table_names = inspector.get_table_names(schema='public') 
            
            for table_name in table_names:
                # DROP old policy to make the script repeatable
                con.execute(
                    text(f'DROP POLICY IF EXISTS "Allow public read access" ON public.{table_name};')
                )
                
                # ENABLE RLS
                con.execute(
                    text(f"ALTER TABLE public.{table_name} ENABLE ROW LEVEL SECURITY;")
                )
                
                # CREATE the SELECT-only policy for 'anon' (public)
                con.execute(
                    text(f"""CREATE POLICY "Allow public read access"
                             ON public.{table_name}
                             FOR SELECT
                             TO anon
                             USING (true);""")
                )
        
        logger.info(f"READ ONLY was given to anon on all 'public' tables in {database_type}.")
        
    except Exception as e:
        logger.error(f"Failed to set RLS on {database_type}: {e}")
       

give_read_access(local_engine, "local")
give_read_access(cloud_engine, "cloud")