using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TEST
{
    public partial class Ventas : Page
    {
        ServicioTest serv = new ServicioTest();

        public string fecha
        {
            get
            {
                var Hoy = DateTime.Now;
                return Hoy.ToString("g");
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            var lstventa = serv.GetVentas();
            ventas.DataSource = lstventa;
            ventas.DataBind();

            var lstproveedor = serv.GetProveedores();
            proveedores.DataSource = lstproveedor;
            proveedores.DataBind();

            fltproveedores.DataSource = lstproveedor;
            fltproveedores.DataBind();
        }
    }
}