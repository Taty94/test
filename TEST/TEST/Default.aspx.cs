using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TEST
{
    public partial class _Default : Page
    {
        ServicioTest serv = new ServicioTest();
        protected void Page_Load(object sender, EventArgs e)
        {
            var lstproveedor = serv.GetProveedores();
            proveedores.DataSource = lstproveedor;
            proveedores.DataBind();
        }
    }
}