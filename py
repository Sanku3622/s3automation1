def runpostgresqlScript():
    #file containing the queries
    query_file = sys.argv[2]
 
    # Define the connection parameters for Redshift
    host = sys.argv[3]
    port = sys.argv[4]
    database = sys.argv[5]
    user = sys.argv[6]
    password = sys.argv[7]
 
    # Read the SQL queries from the file
    with open(query_file, 'r') as file:
       queries = file.read()
 
    # Split the queries into separate statements
    query_statements = queries.split(';')
 
    # Create a connection to Postgres
    conn = psycopg2.connect(
        host=host,
        port=port,
        database=database,
        user=user,
        password=password
    )
 
    # Create a cursor object to execute queries
    cursor = conn.cursor()
 
    # Execute each query one by one
    modified_output = ''
    for statement in query_statements:
        # Skip empty statements
        if not statement.strip():
            continue

        table_name = statement.split('TRUNCATE TABLE')[1].strip()

        # Execute the current statement
        cursor.execute(statement)

        # Count rows after truncate
        cursor.execute(f"SELECT COUNT(*) FROM {table_name}")
        post_truncate_count = cursor.fetchone()[0]
 
        # Check if the TRUNCATE was successful
        if post_truncate_count == 0:
           result=f"Table '{table_name}' was successfully truncated."
        else:   
           result=f"Error: Table '{table_name}' not truncated."

        # Append the table_name and result to the modified output
        modified_output += f'{result}\n'
 
    # Commit the transaction and close the connection
    conn.commit()
    cursor.close()
    conn.close()
 
    # Print or process the modified output as needed
    print(modified_output)
