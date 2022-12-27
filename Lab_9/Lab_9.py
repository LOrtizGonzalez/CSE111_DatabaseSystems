import sqlite3
from sqlite3 import Error


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


def create_View1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V1")
    try:
        sql = """CREATE VIEW V1(c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, c_nation, c_region) AS
        SELECT c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, n_name, r_name
        FROM customer, nation, region
        WHERE r_regionkey = n_regionkey
        AND n_nationkey = c_nationkey
        """

        _conn.execute(sql)
        _conn.commit()
        print("SUCCESS")
    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V2")

    try:
        sql = """CREATE VIEW V2(s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, s_nation, s_region) 
        AS
        SELECT s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, n_name, r_name
        FROM supplier, nation, region
        WHERE r_regionkey = n_regionkey
        AND n_nationkey = s_nationkey"""

        _conn.execute(sql)
        _conn.commit()
        print("SUCCESS")

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V5")

    try:
        sql = """CREATE VIEW V5(o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderyear, o_orderpriority, o_clerk, o_shippriority, o_comment)
        AS
        SELECT o_orderkey, o_custkey, o_orderstatus, o_totalprice, substr(o_orderdate, 1, 4), o_orderpriority,
                 o_clerk, o_shippriority, o_comment
                FROM orders"""
        _conn.execute(sql)
        _conn.commit()
        print("SUCCESS")
    
    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View10(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V10")

    try:
        sql = """CREATE VIEW V10(p_type, min_discount, max_discount) 
                AS
                SELECT p_type, (min(l_discount) * p_retailprice), (max(l_discount) * p_retailprice)
                FROM part, lineitem
                WHERE p_partkey = l_partkey
                Group by p_type
            """
        _conn.execute(sql)
        _conn.commit()
        print("SUCCESS")

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View151(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V151")

    try:
        sql = """CREATE VIEW V151(c_custkey, c_name, c_nationkey, c_acctbal) 
                AS
                SELECT c_custkey, c_name, c_nationkey, c_acctbal
                FROM customer, nation
                WHERE n_nationkey = c_nationkey
                Group by c_custkey
                Having c_acctbal > 0;
            """
        _conn.execute(sql)
        _conn.commit()
        print("SUCCESS")

    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View152(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V152")

    try:
        sql = """CREATE VIEW V152(s_suppkey, s_name, s_nationkey, s_acctbal) 
                AS
                SELECT s_suppkey, s_name, s_nationkey, s_acctbal
                FROM supplier, nation
                WHERE n_nationkey = s_nationkey
                GROUP BY s_suppkey
                HAVING s_acctbal < 0;
            """
        _conn.execute(sql)
        _conn.commit()
        print("SUCCESS")
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q1")
    c = _conn.cursor()

    c.execute("""SELECT c_name, round(sum(o_totalprice),2)
     FROM orders, V1 
     WHERE c_nation = 'FRANCE'
     AND (o_orderdate BETWEEN '1995-01-01' AND '1995-12-31')
     AND o_custkey = c_custkey 
     GROUP BY c_name """)

    results = c.fetchall()
    with open("output/1.out","w") as f:
        for row in results:
            f.write("{0:>10}|{1:<46}\n".format(*row))
            print(row)

    print("++++++++++++++++++++++++++++++++++")


def Q2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q2")
    c = _conn.cursor()

    c.execute("""SELECT s_region, count(s_suppkey) 
                FROM V2
                GROUP BY s_region; 
                """)

    results = c.fetchall()
    with open("output/2.out","w") as f:
        for row in results:
            f.write("{0:}|{1:<46}\n".format(*row))
            print(row)

    print("++++++++++++++++++++++++++++++++++")


def Q3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q3")
    c = _conn.cursor()

    c.execute("""SELECT c_nation, count(o_orderkey)
     FROM orders, V1
     WHERE c_region = "AMERICA" AND o_custkey = c_custkey
     GROUP BY c_nation;""")

    results = c.fetchall()
    with open("output/3.out","w") as f:
        for row in results:
            f.write("{0:}|{1:<46}\n".format(*row))
            print(row)

    print("++++++++++++++++++++++++++++++++++")


def Q4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q4")
    c = _conn.cursor()

    c.execute("""SELECT s_name , count(p_partkey) 
     FROM part, V2, partsupp
     WHERE s_nation = "CANADA" AND ps_suppkey = s_suppkey AND p_partkey = ps_partkey AND p_size < 20
     GROUP BY s_name;""")

    results = c.fetchall()
    with open("output/4.out","w") as f:
        for row in results:
            f.write("{0:}|{1:<46}\n".format(*row))
            print(row)

    print("++++++++++++++++++++++++++++++++++")


def Q5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q5")
    c = _conn.cursor()

    c.execute("""SELECT c_name, count(o_orderkey)
        FROM V1, V5
        WHERE c_nation = "GERMANY" AND o_orderyear = '1993' AND o_custkey = c_custkey
        GROUP BY c_name;""")

    results = c.fetchall()
    with open("output/5.out","w") as f:
        for row in results:
            f.write("{0:}|{1:<46}\n".format(*row))
            print(row)

    print("++++++++++++++++++++++++++++++++++")


def Q6(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q6")
    c = _conn.cursor()

    c.execute("""SELECT s_name, o_orderpriority, count(distinct ps_partkey)
            FROM partsupp, V5, lineitem, supplier, nation
            WHERE l_orderkey = o_orderkey
                and l_partkey = ps_partkey
                and l_suppkey = ps_suppkey
                and ps_suppkey = s_suppkey
                and s_nationkey = n_nationkey
                and n_name = 'CANADA'
            GROUP BY s_name, o_orderpriority;""")

    results = c.fetchall()
    with open("output/6.out","w") as f:
        for row in results:
            f.write("{0:}|{1:}|{2:}\n".format(*row))
            print(row)

    print("++++++++++++++++++++++++++++++++++")


def Q7(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q7")
    c = _conn.cursor()

    c.execute("""SELECT c_nation, o_orderstatus, count(o_orderkey)
     FROM V5, V1
     WHERE c_region = "AMERICA"
     AND o_custkey = c_custkey
     GROUP BY c_nation, o_orderstatus;""")

    results = c.fetchall()
    with open("output/7.out","w") as f:
        for row in results:
            f.write("{0:}|{1:}|{2:}\n".format(*row))
            print(row)

    print("++++++++++++++++++++++++++++++++++")


def Q8(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q8")
    c = _conn.cursor()

    c.execute("""SELECT s_nation, count(DISTINCT(o_orderkey))
     FROM V5, V2, lineitem
     WHERE o_orderstatus = 'F' AND  o_orderyear = '1995' AND l_orderkey = o_orderkey
     AND s_suppkey = l_suppkey
     GROUP BY s_nation
     HAVING count(DISTINCT(o_orderkey)) > 50;""")

    results = c.fetchall()
    with open("output/8.out","w") as f:
        for row in results:
            f.write("{0:}|{1:}\n".format(*row))
            print(row)

    print("++++++++++++++++++++++++++++++++++")


def Q9(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q9")
    c = _conn.cursor()

    c.execute("""SELECT count(Distinct(o_clerk))
     FROM V5, V2, lineitem
     WHERE s_nation = "UNITED STATES" AND l_suppkey = s_suppkey
     AND o_orderkey = l_orderkey;""")

    results = c.fetchall()
    with open("output/9.out","w") as f:
        for row in results:
            f.write("{0:}\n".format(*row))
            print(row)

    print("++++++++++++++++++++++++++++++++++")


def Q10(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q10")
    c = _conn.cursor()

    c.execute("""SELECT p_type, min_discount, max_discount
     FROM V10
     WHERE p_type like 'ECONOMY%COPPER'
     group by p_type;""")

    results = c.fetchall()
    with open("output/10.out","w") as f:
        for row in results:
            f.write("{0:}|{1:}|{2:}\n".format(*row))
            print(row)

    print("++++++++++++++++++++++++++++++++++")


def Q11(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q11")
    c = _conn.cursor()

    c.execute("""SELECT s_region, s_name, MAX(s_acctbal)
     FROM V2
     Group by s_region
     Having MAX(s_acctbal);""")

    results = c.fetchall()
    with open("output/11.out","w") as f:
        for row in results:
            f.write("{0:}|{1:}|{2:}\n".format(*row))
            print(row)

    print("++++++++++++++++++++++++++++++++++")


def Q12(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q12")
    c = _conn.cursor()

    c.execute("""SELECT s_nation, MAX(s_acctbal)
     FROM V2
     Group by s_nation
     Having s_acctbal > 9000;""")

    results = c.fetchall()
    with open("output/12.out","w") as f:
        for row in results:
            f.write("{0:}|{1:}\n".format(*row))
            print(row)

    print("++++++++++++++++++++++++++++++++++")


def Q13(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q13")
    c = _conn.cursor()

    c.execute("""SELECT count(l_orderkey)
     FROM lineitem, V1, V2, orders
     WHERE c_nation = "UNITED STATES" AND s_region = "AFRICA"
     AND l_suppkey = s_suppkey
     AND o_orderkey = l_orderkey AND o_custkey = c_custkey;""")

    results = c.fetchall()
    with open("output/13.out","w") as f:
        for row in results:
            f.write("{0:}\n".format(*row))
            print(row)

    print("++++++++++++++++++++++++++++++++++")


def Q14(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q14")
    c = _conn.cursor()

    c.execute("""SELECT s_region, c_region, MAX(o_totalprice)
     FROM orders, lineitem, V1, V2
     WHERE l_suppkey = s_suppkey AND o_orderkey = l_orderkey
     AND o_custkey = c_custkey
     Group by s_region, c_region
     Having MAX(o_totalprice);""")

    results = c.fetchall()
    with open("output/14.out","w") as f:
        for row in results:
            f.write("{0:}|{1:}|{2:}\n".format(*row))
            print(row)

    print("++++++++++++++++++++++++++++++++++")


def Q15(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q15")
    c = _conn.cursor()

    c.execute("""SELECT count(DISTINCT (o_orderkey))
     FROM orders, V151, V152, lineitem
     WHERE s_suppkey = l_suppkey AND o_orderkey = l_orderkey
     AND c_custkey = o_custkey;""")

    results = c.fetchall()
    with open("output/15.out","w") as f:
        for row in results:
            f.write("{0:}\n".format(*row))
            print(row)

    print("++++++++++++++++++++++++++++++++++")


def main():
    database = r"tpch.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        create_View1(conn)
        Q1(conn)

        create_View2(conn)
        Q2(conn)

        Q3(conn)
        Q4(conn)

        create_View5(conn)
        Q5(conn)

        Q6(conn)
        Q7(conn)
        Q8(conn)
        Q9(conn)

        create_View10(conn)
        Q10(conn)

        Q11(conn)
        Q12(conn)
        Q13(conn)
        Q14(conn)

        create_View151(conn)
        create_View152(conn)
        Q15(conn)

    closeConnection(conn, database)


if __name__ == '__main__':
    main()
