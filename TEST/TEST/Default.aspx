<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TEST._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>ASP.NET WEB APP WITH WEB SERVICE</h1>
        <p class="lead">ASP.NET Web Service Using jQuery Ajax With Crud</p>
        <p><a href="http://www.dynamitetechnology.in" class="btn btn-primary btn-lg">Contact us</a></p>
    </div>

    <div class="container">
        <%--<div class="row">
            <div class="col-md-3">
                <label for="exampleInputEmail1">Serch</label>
                <input type="text" class="form-control  rounded-0 mb-3" id="serchtext">
            </div>
        </div>--%>
        <table class="table" id="tblrpoveedores">
           <caption>
                <button type="button" class="btn btn-success rounded-0" data-toggle="modal" data-target="#AddProveedor">Agregar Proveedor</button>
            </caption>
            <thead class="thead-dark">
                <tr>
                    <th>#</th>
                    <th>RUC</th>
                    <th>Nombre</th>
                    <th>Direccion</th>
                    <th>Email</th>
                    <th>Telefono</th>
                    <th>Accion</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="proveedores" runat="server">
                    <ItemTemplate>
                        <tr>
                            <th><%#Eval("proveedor_id")%></th>
                            <td><%#Eval("proveedor_ruc")%></td>
                            <td><%#Eval("proveedor_nombre")%></td>
                            <td><%#Eval("proveedor_direccion")%></td>
                            <td><%#Eval("proveedor_email")%></td>
                            <td><%#Eval("proveedor_telefono")%></td>
                            <td><a class="editModal" data-edit="<%#Eval("proveedor_id")%>">Editar</a>
                                <a class="deletedata" data-id="<%#Eval("proveedor_id")%>">Eliminar</a>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>
    

    <!-- Modal -->
    <div class="modal fade" id="AddProveedor" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">Nuevo Proveedor</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="nombre">Nombre</label>
                        <input type="text" class="form-control rounded-0" id="txtnombre">
                    </div>
                    <div class="form-group">
                        <label for="ruc">RUC</label>
                        <input type="text" class="form-control  rounded-0" id="txtruc">
                    </div>
                    <div class="form-group">
                        <label for="direccion">Direccion</label>
                        <input type="text" class="form-control  rounded-0" id="txtdireccion">
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" class="form-control  rounded-0" id="txtemail">
                    </div>
                    <div class="form-group">
                        <label for="telefono">Telefono</label>
                        <input type="text" class="form-control  rounded-0" id="txttelf">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary  rounded-0" data-dismiss="modal">Cerrar</button>
                    <button type="button" class="btn btn-success  rounded-0 AddProveedor">Guardar</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal -->
    <div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">Editar Proveedor</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <input type="hidden" class="form-control rounded-0" id="etxtid" >
                        <label for="nombre">Nombre</label>
                        <input type="text" class="form-control rounded-0" id="etxtnombre">
                    </div>
                    <div class="form-group">
                        <label for="ruc">RUC</label>
                        <input type="text" class="form-control  rounded-0" id="etxtruc">
                    </div>
                    <div class="form-group">
                        <label for="direccion">Direccion</label>
                        <input type="text" class="form-control  rounded-0" id="etxtdireccion">
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" class="form-control  rounded-0" id="etxtemail">
                    </div>
                    <div class="form-group">
                        <label for="telefono">Telefono</label>
                        <input type="text" class="form-control  rounded-0" id="etxttelf">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary  rounded-0" data-dismiss="modal">Cerrar</button>
                    <button type="button" class="btn btn-success  rounded-0 EditProveedor">Guardar</button>
                </div>
            </div>
        </div>
    </div>

    <script>        

        $(".AddProveedor").click(function () {
            var nuevo = new Object();
            nuevo.proveedor_id = 0;
            nuevo.proveedor_ruc = $("#txtruc").val();
            nuevo.proveedor_nombre = $("#txtnombre").val();
            nuevo.proveedor_direccion = $("#txtdireccion").val();
            nuevo.proveedor_email = $("#txtemail").val();
            nuevo.proveedor_telefono = $("#txttelf").val();

            let sendData = {
                objproveedor:nuevo
            }
            callApi(apiUrl + "/AddEditProveedor", JSON.stringify(sendData), function (result) {
                console.log(result);
                $("#AddProveedor").modal('hide');
                location.reload()
            });
        });

        $(".editModal").click(function () {
            var editid = $(this).attr("data-edit");

            let sendData = {
                proveedor_id: editid
            }
            callApi(apiUrl + "/GetProveedorById", JSON.stringify(sendData), function (result) {
                $("#etxtid").val(result.d.proveedor_id);
                $("#etxtruc").val(result.d.proveedor_ruc);
                $("#etxtnombre").val(result.d.proveedor_nombre);
                $("#etxtdireccion").val(result.d.proveedor_direccion);
                $("#etxtemail").val(result.d.proveedor_email);
                $("#etxttelf").val(result.d.proveedor_telefono);

                $("#updateModal").modal('show');
            });
        });

        $(".EditProveedor").click(function () {
            var edit = new Object();
            edit.proveedor_id = $("#etxtid").val();
            edit.proveedor_ruc = $("#etxtruc").val();
            edit.proveedor_nombre = $("#etxtnombre").val();
            edit.proveedor_direccion = $("#etxtdireccion").val();
            edit.proveedor_email = $("#etxtemail").val();
            edit.proveedor_telefono = $("#etxttelf").val();

            let sendData = {
                objproveedor: edit
            }
            callApi(apiUrl + "/AddEditProveedor", JSON.stringify(sendData), function (result) {
                $("#updateModal").modal('hide');
                location.reload();
                
            });

            
        });


        $(".deletedata").click(function () {

            Swal.fire({
                title: 'Estas seguro?',
                text: "No podras revertirlo :/!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Si, borrar!'
            }).then((result) => {
                if (result.isConfirmed) {
                    var id = $(this).attr("data-id");

                    let sendData = {
                        proveedor_id: id
                    }
                    callApi(apiUrl + "/DeleteProveedorById", JSON.stringify(sendData), function (result) {
                        console.log(result.d);
                        if (result.d) {
                            location.reload();
                        }

                    });
                }
            })
            
        });

    </script>
</asp:Content>
