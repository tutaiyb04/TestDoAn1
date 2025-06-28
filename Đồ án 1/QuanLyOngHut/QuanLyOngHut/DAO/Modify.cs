using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;




namespace QuanLyOngHut.DAO
{
    class Modify
    {
        public Modify()
        {
        }

        SqlCommand sqlCommand; // Dùng để truy vấn các câu lệnh INSERT, UPDATE, DELE,...
        SqlDataReader reader; // Dùng để đọc dữ liệu trong bảng 
        public List<TaiKhoan> TaiKhoans(string tenDangNhap, string matKhau)
        {
            List<TaiKhoan> taiKhoans = new List<TaiKhoan>();
            string query = "SELECT * FROM TaiKhoan WHERE TenDangNhap = @TenDangNhap AND MatKhau = @MatKhau";

            using (SqlConnection sqlConnection = KetNoi.GetSqlConnection())
            {
                sqlConnection.Open();
                sqlCommand = new SqlCommand(query, sqlConnection);

                // Thêm các tham số vào truy vấn
                sqlCommand.Parameters.AddWithValue("@TenDangNhap", tenDangNhap);
                sqlCommand.Parameters.AddWithValue("@MatKhau", matKhau);

                reader = sqlCommand.ExecuteReader();
                while (reader.Read())
                {
                    taiKhoans.Add(new TaiKhoan(reader.GetString(0), reader.GetString(1)));
                }

                reader.Close();
                sqlConnection.Close();
            }

            return taiKhoans;
        }
    }
}
