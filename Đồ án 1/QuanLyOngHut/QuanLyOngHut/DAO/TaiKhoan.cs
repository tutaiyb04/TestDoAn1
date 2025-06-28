using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyOngHut.DAO
{
    class TaiKhoan
    {
        private String tenTaiKhoan;
        private String matKhau;

        public TaiKhoan() 
        {
            
        }

        public TaiKhoan(String tenTaiKhoan, String matKhau)
        {
            this.tenTaiKhoan = tenTaiKhoan;
            this.matKhau = matKhau;
        }

        public string TenTaiKhoan { get => tenTaiKhoan; set => tenTaiKhoan = value; }
        public string MatKhau { get => matKhau; set => matKhau = value; }

        internal static void Add(TaiKhoan taiKhoan)
        {
            throw new NotImplementedException();
        }
    }
}
