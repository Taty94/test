<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Ventas.aspx.cs" Inherits="TEST.Ventas" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .modal-dialog {
            width: 900px;
            margin: 30px auto;
        }
    </style>
    
    <div class="jumbotron">
        <h1>ASP.NET WEB APP WITH WEB SERVICE</h1>
        <p class="lead">ASP.NET Web Service Using jQuery Ajax With Crud</p>
        <p><a href="http://www.dynamitetechnology.in" class="btn btn-primary btn-lg">Contact us</a></p>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-md-3">
                <label for="">Fecha Inicio</label>
                <input type="date" class="form-control  rounded-0 mb-3" id="fechaini">
            </div>
            <div class="col-md-3">
                <label for="">Fecha Fin</label>
                <input type="date" class="form-control  rounded-0 mb-3" id="fechafin">
            </div>
            <div class="col-md-3">
                <label for="">Proveedores</label>
                <select class="form-control" id="idprov">
                    <option value="">Seleccione Proveedor</option>
                    <asp:Repeater ID="fltproveedores" runat="server">
                        <ItemTemplate>
                            <option value="<%#Eval("proveedor_id")%>"><%#Eval("proveedor_nombre")%></option>
                        </ItemTemplate>
                    </asp:Repeater>
                </select>
            </div>
            <div class="col-md-3" style="margin-top:22px">
                <button type="button" class="btn btn-primary rounded-0" id="filter">Filtrar</button>
                <button type="button" class="btn btn-primary rounded-0" id="quit">Quitar Filtro</button>
            </div>
        </div>
        <table class="table" id="tblrpoveedores">
           <caption>
                <button type="button" class="btn btn-success rounded-0" data-toggle="modal" data-target="#AddVenta">Agregar Venta</button>
            </caption>
            <thead class="thead-dark">
                <tr>
                    <th>#</th>
                    <th>Proveedor</th>
                    <th>Producto</th>
                    <th>Descripcion</th>
                    <th>Fecha</th>
                    <th>Total</th>
                    <th>Accion</th>
                </tr>
            </thead>
            <tbody id="ventaslistado">
                <asp:Repeater ID="ventas" runat="server">
                    <ItemTemplate>
                        <tr>
                            <th><%#Eval("ventas_id")%></th>
                            <td><%#Eval("proveedor.proveedor_nombre")%></td>
                            <td><%#Eval("ventas_producto")%></td>
                            <td><%#Eval("ventas_descripcion")%></td>
                            <td><%#Eval("ventas_fecha")%></td>
                            <td><%#Eval("ventas_total")%></td>
                            <td><a class="editModal" data-edit="<%#Eval("ventas_id")%>">Editar</a>
                                <a class="deletedata" data-id="<%#Eval("ventas_id")%>">Eliminar</a>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>
    

    <!-- Modal -->
    <div class="modal fade" id="AddVenta" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="">Nueva Venta</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="prod">Proveedor</label>
                        <select class="form-control" id="txtproveedor">
                            <asp:Repeater ID="proveedores" runat="server">
                                <ItemTemplate>
                                    <option value="<%#Eval("proveedor_id")%>"><%#Eval("proveedor_nombre")%></option>
                                </ItemTemplate>
                            </asp:Repeater>
                        </select>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="prod">Producto</label>
                                <input type="text" class="form-control rounded-0" id="txtproducto">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="descri">Descripcion</label>
                                <input type="text" class="form-control  rounded-0" id="txtdescrip">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="precio">Precio</label>
                                <input type="text" class="form-control  rounded-0" id="txtprecio">
                            </div>
                        </div>
<%--                        <div class="col-md-2">
                            <div class="form-group">
                                <a href="#" id="add">Agregar</a>
                            </div>
                        </div>--%>
                    </div>
                    <table class="table" id="tblventas">
                        <thead class="thead-dark">
                            <tr>
                                <th>#</th>
                                <th>Producto</th>
                                <th>Descripcion</th>
                                <th>Fecha</th>
                                <th>Total</th>
                                <th>Accion</th>
                            </tr>
                        </thead>
                        <tbody id="ventanew">
                            
                        </tbody>
        </table>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-success  rounded-0 AddVenta">PreGuardar</button>
                    <button type="button" class="btn btn-primary  rounded-0 AddClose">Guardar y Cerrar</button>
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
                    <h4 class="modal-title" id="">Editar Proveedor</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                
                                <input type="hidden" class="form-control rounded-0" id="txtidventa" >
                                <input type="hidden" class="form-control rounded-0" id="txtidproveedor" >
                                <label for="prov">Proveedor</label>
                                <input type="text" class="form-control rounded-0" id="etxtproveedor" disabled>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="prod">Producto</label>
                                <input type="text" class="form-control rounded-0" id="etxtproducto">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="descri">Descripcion</label>
                                <input type="text" class="form-control  rounded-0" id="etxtdescrip">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="precio">Precio</label>
                                <input type="text" class="form-control  rounded-0" id="etxtprecio">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary  rounded-0" data-dismiss="modal">Cerrar</button>
                    <button type="button" class="btn btn-success  rounded-0 EditVenta">Guardar</button>
                </div>
            </div>
        </div>
    </div>

    <script >
       
        var cont = 1;
        var listvent = [];
        $(".AddVenta").click(function () {
                
                var nueva = new Object();
                nueva.ventas_id = cont;
                nueva.ventas_idproveedor = $("#txtproveedor").val();;
                nueva.ventas_producto = $("#txtproducto").val();
                nueva.ventas_descripcion = $("#txtdescrip").val();
                nueva.ventas_fecha = '<%= fecha %>';
                nueva.ventas_total = $("#txtprecio").val();
                
                listvent.push(nueva);
            var string = `<tr id="` + cont +`" >
                            <th >` + cont +`</th>
                            <td >`+ nueva.ventas_producto +`</td>
                            <td>`+ nueva.ventas_descripcion +`</td>
                            <td>`+ nueva.ventas_fecha +`</td>
                            <td>`+ nueva.ventas_total +`</td>
                            <td>
                                <a onclick="remove(`+ cont +`)">Eliminar</a>
                            </td></tr>`
                

                $(string).appendTo("#ventanew");
                cont++;
           
        });

        function remove(id) {
            listvent = $.grep(listvent, function (e) {
                return e.ventas_id != id;
            });
            $("#" + id).remove();
            
        }

        $(".AddClose").click(function () {
            if (listvent.length != 0) {
                listvent.forEach(element => element.ventas_id = 0);
                let sendData = {
                    lstventas: listvent
                }
                console.log(sendData);
                callApi(apiUrl + "/AddEditVentas", JSON.stringify(sendData), function (result) {
                    $("#AddVenta").modal('hide');
                    if (result.d) {
                        location.reload();
                    } else {
                        Swal.fire({
                            position: 'top-end',
                            icon: 'warning',
                            title: 'Algo sucedio durante el proceso , intentelo mas tarde',
                            showConfirmButton: false,
                            timer: 1500
                        })
                    }

                    
                });
            } else {
                Swal.fire({
                    position: 'top-end',
                    icon: 'warning',
                    title: 'Es necesario pre-guardar antes de guardar',
                    showConfirmButton: false,
                    timer: 1500
                })
            }
        });

        $(".editModal").click(function () {
            var editid = $(this).attr("data-edit");

            let sendData = {
                ventas_id: editid
            }
            callApi(apiUrl + "/GetVentaById", JSON.stringify(sendData), function (result) {
                $("#etxtproveedor").val(result.d.proveedor.proveedor_nombre);
                $("#txtidventa").val(result.d.ventas_id);
                $("#txtidproveedor").val(result.d.ventas_idproveedor);
                $("#etxtproducto").val(result.d.ventas_producto);
                $("#etxtdescrip").val(result.d.ventas_descripcion);
                $("#etxtprecio").val(result.d.ventas_total);

                $("#updateModal").modal('show');
            });
        });

        $(".EditVenta").click(function () {
            var lsteditventa = [];
            var edit = new Object();
            edit.ventas_id = $("#txtidventa").val();
            edit.ventas_idproveedor = $("#txtidproveedor").val();
            edit.ventas_producto = $("#etxtproducto").val();
            edit.ventas_descripcion = $("#etxtdescrip").val();
            edit.ventas_fecha = '<%= fecha %>';
            edit.ventas_total = $("#etxtprecio").val();
            lsteditventa.push(edit);
            let sendData = {
                lstventas: lsteditventa
            }
            callApi(apiUrl + "/AddEditVentas", JSON.stringify(sendData), function (result) {
                $("#updateModal").modal('hide');
                if (result.d) {
                    location.reload();
                } else {
                    Swal.fire({
                        position: 'top-end',
                        icon: 'warning',
                        title: 'Algo sucedio durante el proceso , intentelo mas tarde',
                        showConfirmButton: false,
                        timer: 1500
                    })
                }
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
                        ventas_id: id
                    }
                    callApi(apiUrl + "/DeleteVentaById", JSON.stringify(sendData), function (result) {
                        console.log(result.d);
                        if (result.d) {
                            location.reload();
                        }

                    });
                }
                
            });
        });

        $("#filter").click(function () {
            var fechaini = $("#fechaini").val();
            var fechafin = $("#fechafin").val();
            var idproveedor = $("#idprov").val();

            let sendData = {
                fechaini: fechaini,
                fechafin: fechafin,
                idproveedor: idproveedor
            }
            console.log(sendData);
            callApi(apiUrl + "/FilterVentas", JSON.stringify(sendData), function (result) {
                console.log(result.d);
                $("#ventaslistado").empty();
                var string = '';
                for (var i = 0; i < result.d.length; i++) {
                    string += `<tr>
                            <th>`+ result.d[i].ventas_id + `</th>
                            <td>`+ result.d[i].proveedor.proveedor_nombre + `</td>
                            <td>`+ result.d[i].ventas_producto + `</td>
                            <td>`+ result.d[i].ventas_descripcion + `</td>
                            <td>`+ result.d[i].venta_fecha + `</td>
                            <td>`+ result.d[i].ventas_total + `</td>
                            <td><a onclick="EditModal(`+ result.d[i].ventas_id + `)">Editar</a>
                                <a onclick="DeleteData(`+ result.d[i].ventas_id + `)">Eliminar</a>
                            </td>
                        </tr>`;
                }

                $(string).appendTo("#ventaslistado");
            });
        });

        function EditModal(editid) {

            let sendData = {
                ventas_id: editid
            }
            callApi(apiUrl + "/GetVentaById", JSON.stringify(sendData), function (result) {
                $("#etxtproveedor").val(result.d.proveedor.proveedor_nombre);
                $("#txtidventa").val(result.d.ventas_id);
                $("#txtidproveedor").val(result.d.ventas_idproveedor);
                $("#etxtproducto").val(result.d.ventas_producto);
                $("#etxtdescrip").val(result.d.ventas_descripcion);
                $("#etxtprecio").val(result.d.ventas_total);

                $("#updateModal").modal('show');
            });
        }

        function DeleteData(id) {
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
                    let sendData = {
                        ventas_id: id
                    }
                    callApi(apiUrl + "/DeleteVentaById", JSON.stringify(sendData), function (result) {
                        console.log(result.d);
                        if (result.d) {
                            location.reload();
                        }

                    });
                }
            })
        }

        $("#quit").click(function () {
            location.reload();
        });
    </script>

</asp:Content>
