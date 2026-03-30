import vertica_python

conn_info = {'host': 'vertica.data-engineer.education-services.ru',
             'port': 5433,
             'user': 'vt260324747f4b',
             'password': '3de4f3a6fb7f4bbe987e079483878597',
             'database': 'dwh',
             # Вначале он нам понадобится, а дальше — решите позже сами
            'autocommit': True
}

def try_select(conn_info=conn_info):
	# И рекомендуем использовать соединение вот так
	with vertica_python.connect(**conn_info) as conn:
		cur = conn.cursor()
		cur.execute("SELECT 1 as a1")

		res = cur.fetchall()
		return res