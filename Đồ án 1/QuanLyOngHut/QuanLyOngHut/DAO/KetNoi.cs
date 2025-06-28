using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace QuanLyOngHut.DAO
{
    class KetNoi
    {
        private static String chuoiKetNoi = @"Data Source=LAPTOP-EAA1P14R\SQLEXPRESS;Initial Catalog=QuanLyOngHut;Integrated Security=True;Encrypt=False";

        public static SqlConnection GetSqlConnection()
        {
            return new SqlConnection(chuoiKetNoi);
        }
    }
}
