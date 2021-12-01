using Dapper;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;

namespace TEST
{
    /// <summary>
    /// Summary description for ServicioTest
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class ServicioTest : System.Web.Services.WebService
    {
        private static string ConnectionString => ConfigurationManager.ConnectionStrings["dbtestEntities"].ConnectionString;

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod]
        public List<proveedor> GetProveedores()
        {
            using (dbtestEntities1 ent = new dbtestEntities1())
            {
                var proveedores = ent.proveedor.ToList();
                return proveedores;
            }
        }

        [WebMethod]
        public proveedor AddEditProveedor(proveedor objproveedor)
        {
            using (dbtestEntities1 ent = new dbtestEntities1())
            {
                if (objproveedor.proveedor_id == 0)
                {
                    var proveedor = ent.proveedor.Add(objproveedor);
                    ent.SaveChanges();
                }
                else
                {
                    var proveedor = ent.proveedor.Where(x => x.proveedor_id == objproveedor.proveedor_id).FirstOrDefault();
                    if (proveedor != null)
                    {
                        proveedor.proveedor_id = objproveedor.proveedor_id;
                        proveedor.proveedor_ruc = objproveedor.proveedor_ruc;
                        proveedor.proveedor_nombre = objproveedor.proveedor_nombre;
                        proveedor.proveedor_direccion = objproveedor.proveedor_direccion;
                        proveedor.proveedor_email = objproveedor.proveedor_email;
                        proveedor.proveedor_telefono = objproveedor.proveedor_telefono;

                        ent.SaveChanges();
                    }
                }
                
                return objproveedor;               
            }
        }

        [WebMethod]
        public proveedor GetProveedorById(int proveedor_id)
        {
            using (dbtestEntities1 ent = new dbtestEntities1())
            {
                var proveedor = ent.proveedor.Where(x => x.proveedor_id == proveedor_id).FirstOrDefault();
                return proveedor;
            }

         
        }

        [WebMethod]
        public bool DeleteProveedorById(int proveedor_id)
        {
            using (dbtestEntities1 ent = new dbtestEntities1())
            {
                var proveedor = ent.proveedor.Where(x => x.proveedor_id == proveedor_id).FirstOrDefault();
                ent.proveedor.Remove(proveedor);
                var value = ent.SaveChanges();
                var result= value==1?true:false;
                return result;
            }


        }


        //VENTAS

        [WebMethod]
        public List<ventas> GetVentas()
        {
            using (dbtestEntities1 ent = new dbtestEntities1())
            {
                var ventas = ent.ventas.ToList();
                return ventas;
            }
        }

        [WebMethod]
        public bool AddEditVentas(List<ventas> lstventas)
        {
            try
            {
                using (dbtestEntities1 ent = new dbtestEntities1())
                {
                    foreach (var objventas in lstventas)
                    {
                        if (objventas.ventas_id == 0)
                        {
                            var venta = ent.ventas.Add(objventas);
                            ent.SaveChanges();
                        }
                        else
                        {
                            var venta = ent.ventas.Where(x => x.ventas_id == objventas.ventas_id).FirstOrDefault();
                            if (venta != null)
                            {
                                venta.ventas_id = objventas.ventas_id;
                                venta.ventas_idproveedor = objventas.ventas_idproveedor;
                                venta.ventas_producto = objventas.ventas_producto;
                                venta.ventas_descripcion = objventas.ventas_descripcion;
                                venta.ventas_fecha = objventas.ventas_fecha;
                                venta.ventas_total = objventas.ventas_total;

                                ent.SaveChanges();
                            }
                        }
                    }


                    return true;

                }
            }catch(Exception ex)
            {
                var error = ex.Message;
                return false;
            }
        }

        [WebMethod]
        public ventas GetVentaById(int ventas_id)
        {
            using (dbtestEntities1 ent = new dbtestEntities1())
            {
                var venta = ent.ventas.Where(x => x.ventas_id == ventas_id).FirstOrDefault();
                return venta;
            }


        }

        [WebMethod]
        public bool DeleteVentaById(int ventas_id)
        {
            using (dbtestEntities1 ent = new dbtestEntities1())
            {
                var venta = ent.ventas.Where(x => x.ventas_id == ventas_id).FirstOrDefault();
                ent.ventas.Remove(venta);
                var value = ent.SaveChanges();
                var result = value == 1 ? true : false;
                return result;
            }


        }

        [WebMethod]
        public List<ventas> FilterVentas(string fechaini, string fechafin,string idproveedor)
        {
            using (dbtestEntities1 ent = new dbtestEntities1())
            {
                DateTime inicio;
                int idia, imes, ianio;
                DateTime fin;
                int fdia, fmes, fanio;
                
                List<ventas> ventas= new List<ventas>();
                if(fechaini!="" && fechafin != "" && idproveedor=="")
                {
                    inicio = DateTime.Parse(fechaini);
                    idia = inicio.Day;
                    imes = inicio.Month;
                    ianio = inicio.Year;
                    fin = DateTime.Parse(fechafin);
                    fdia = fin.Day;
                    fmes = fin.Month;
                    fanio = fin.Year;
                    ventas = ent.ventas.Where(x =>
                                x.ventas_fecha.Day >= idia && x.ventas_fecha.Day <= fdia &&
                                x.ventas_fecha.Month >= imes && x.ventas_fecha.Month <= fmes &&
                                x.ventas_fecha.Year >= ianio && x.ventas_fecha.Year >= fanio 
                            ).ToList();
                    foreach (var item in ventas)
                    {
                        item.venta_fecha = item.ventas_fecha.ToString("g");
                    }
                }
                else if(fechaini == "" && fechafin == ""  && idproveedor != "")
                {
                    var proveedor_id = Convert.ToInt32(idproveedor);
                    ventas = ent.ventas.Where(x => x.ventas_idproveedor == proveedor_id).ToList();
                    foreach (var item in ventas)
                    {
                        item.venta_fecha = item.ventas_fecha.ToString("g");
                    }

                }
                else if (fechaini != "" && fechafin != "" && idproveedor != "")
                {
                    inicio = DateTime.Parse(fechaini);
                    idia = inicio.Day;
                    imes = inicio.Month;
                    ianio = inicio.Year;
                    fin = DateTime.Parse(fechafin);
                    fdia = fin.Day;
                    fmes = fin.Month;
                    fanio = fin.Year;
                    var proveedor_id = Convert.ToInt32(idproveedor);
                    ventas = ent.ventas.Where(x =>
                                x.ventas_fecha.Day >= idia && x.ventas_fecha.Day <= fdia &&
                                x.ventas_fecha.Month >= imes && x.ventas_fecha.Month <= fmes &&
                                x.ventas_fecha.Year >= ianio && x.ventas_fecha.Year >= fanio &&
                                x.ventas_idproveedor == proveedor_id
                            ).ToList();
                    
                    foreach(var item in ventas)
                    {
                        item.venta_fecha = item.ventas_fecha.ToString("g");
                    }
                }
                else if(fechaini == "" && fechafin == "" && idproveedor == "")
                {
                    ventas = ent.ventas.ToList();
                    foreach (var item in ventas)
                    {
                        item.venta_fecha = item.ventas_fecha.ToString("g");
                    }
                }


                return ventas;
            }


        }

    }
}
