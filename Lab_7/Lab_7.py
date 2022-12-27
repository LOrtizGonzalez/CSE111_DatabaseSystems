import sqlite3
from sqlite3 import Error
from sqlite3.dbapi2 import Cursor


def openConnection(_dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Open database: ", _dbFile)

    conn = None
    try:
        conn = sqlite3.connect(_dbFile)
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")

    return conn

def closeConnection(_conn, _dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Close database: ", _dbFile)

    try:
        _conn.close()
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def createTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create table")

    try:
        sql = """CREATE TABLE warehouse (
                    w_warehousekey decimal(9,0) not null,
                    w_name char(100) not null,
                    w_capacity decimal(6,0) not null,
                    w_suppkey decimal(9,0) not null,
                    w_nationkey decimal(2,0) not null)"""
        _conn.execute(sql)
        _conn.commit()
        print("success")
    except Error as e:
        _conn.rollback()
        print(e)
    
    print("++++++++++++++++++++++++++++++++++")


def dropTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Drop tables")

    try:
        sql = """DROP TABLE warehouse"""
        _conn.execute(sql)
        _conn.commit()
        print("success")
    except Error as e:
        _conn.rollback()
        print(e)
    
    print("++++++++++++++++++++++++++++++++++")


def populateTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Populate table")

    try:
        c = _conn.cursor()
        i = 1

        c.execute("SELECT s_suppkey from supplier")
        s_suppkeys = c.fetchall()

        for s_suppkey in s_suppkeys:
            c.execute(f"""
            SELECT
                nation.n_nationkey, nation.n_name, supplier.s_suppkey, supplier.s_name, count(*) as cnt, sum(part.p_size) as cap
            from supplier
            INNER JOIN lineitem ON lineitem.l_suppkey = supplier.s_suppkey
            INNER JOIN part ON lineitem.l_partkey = part.p_partkey
            INNER JOIN orders ON lineitem.l_orderkey = orders.o_orderkey
            INNER JOIN customer ON customer.c_custkey = orders.o_custkey
            INNER JOIN nation ON nation.n_nationkey = customer.c_nationkey
            WHERE supplier.s_suppkey = {s_suppkey[0]}
            GROUP BY nation.n_nationkey
            ORDER BY cnt DESC, nation.n_name;"""
            )
 
            results = c.fetchall()
            nationkey1, cname1, suppkey1, sname1,_,_ = results[0]
            nationkey2, cname2, suppkey2, sname2,_,_ = results[1]

            wname1 = f"{sname1}___{cname1}"
            wname2 = f"{sname2}___{cname2}"
            max_cap = max([result[-1] for result in results])
            shared_cap = max_cap *2

            c.execute(f"""INSERT INTO warehouse VALUES({i}, "{wname1}", {shared_cap}, {suppkey1}, {nationkey1}); """)
            c.execute(f"""INSERT INTO warehouse VALUES({i+1}, "{wname2}", {shared_cap}, {suppkey2}, {nationkey2}); """)
            _conn.commit()
            i+= 2
        #_conn.execute(sql, [w_warehousekey,w_name,w_capacity,w_suppkey, w_nationkey])
        #_conn.commit()
        print("Success!")
    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")

def Q1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q1")

    c = _conn.cursor()

    c.execute("SELECT * from warehouse GROUP BY w_warehousekey ")
    results = c.fetchall()
    with open("output/1.out","w") as f:
        f.write("wId                        wName  wCap   sId  nId\n")
        for result in results:
            f.write("{} {} {} {} {}\n".format(*result))

    print("++++++++++++++++++++++++++++++++++")


def Q2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q2")

    c = _conn.cursor()

    c.execute("""SELECT n_name, count(w_warehousekey), sum(w_capacity)
    FROM nation, warehouse
    WHERE
    w_nationkey = n_nationkey
    GROUP BY n_name
    ORDER BY 
    count(w_warehousekey) DESC, 
    sum(w_capacity) DESC
    
     """)

    results = c.fetchall()
    with open("output/2.out", "w") as f:
        f.write("nation numW   totCap\n")
        for result in results:
            f.write("{} {} {}\n".format(*result))

    print("++++++++++++++++++++++++++++++++++")


def Q3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q3")
    
    with open("input/3.in","r") as r:
    
        data = r.read()
        #print(data)
        try:
            sql = ("""SELECT s_name, N2.n_name, w_name  
                    FROM warehouse, supplier, nation N1, nation N2
                    WHERE s_suppkey = w_suppkey 
                    AND w_nationkey = N1.n_nationkey
                    AND s_nationkey = N2.n_nationkey
                    AND N1.n_name = ?
                    GROUP BY s_name 
                    ORDER BY s_name ASC""")
            args = [data]
            c = _conn.cursor()
            c.execute(sql,args)
            results = c.fetchall()
            with open("output/3.out","w") as f:
                f.write("supplier             nation               warehouse\n")
                for result in results:
                    f.write("{0:<20} {1:20} {2:>10}\n".format(*result))
                    print(result)
        except Error as e:
            _conn.rollback()
            print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q4")

    c = _conn.cursor()
    try:
        with open("input/4.in","r") as r:
            data = r.read().splitlines()
            sql = """SELECT w_name, w_capacity
            FROM warehouse, region, nation
            WHERE w_nationkey = n_nationkey
            AND r_name = ? 
            AND n_regionkey = r_regionkey
            AND w_capacity > ?
            GROUP BY w_name
            ORDER BY  w_capacity DESC
            """
        args = [data[0],data[1]]
        c = _conn.cursor()
        c.execute(sql, args)
    except Error as e:
        _conn.rollback()
        print(e)
    results = c.fetchall()
    with open("output/4.out","w") as f:
        f.write("warehouse                     capacity\n")
        for result in results:
            f.write("{0:<30} {1:20}\n".format(*result))

    print("++++++++++++++++++++++++++++++++++")


def Q5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q5")

    c = _conn.cursor()
    with open("input/5.in","r") as r:
    
    
        c.execute("""SELECT r_name, SUM(results.totCap)
            FROM
                (
                SELECT r1.r_name, SUM(w_capacity) as totCap
                FROM warehouse, supplier, nation n1, nation n2, region r1 
                WHERE
                w_suppkey = s_suppkey AND
                w_nationkey = n2.n_nationkey AND
                s_nationkey = n1.n_nationkey AND
                n2.n_regionkey = r1.r_regionkey AND 
                n1.n_name = " "
                
                GROUP BY r1.r_name
            
                ) as results
                GROUP BY r_name
                """)
    results = c.fetchall()
    
    with open("output/5.out", "w") as f:
        f.write("region    Capacity\n")
        for result in results:
            f.write("{} {}\n".format(*result))


    print("++++++++++++++++++++++++++++++++++")


def main():
    database = r"tpch.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        dropTable(conn)
        createTable(conn)
        populateTable(conn)

        Q1(conn)
        Q2(conn)
        Q3(conn)
        Q4(conn)
        Q5(conn)

    closeConnection(conn, database)


if __name__ == '__main__':
    main()
