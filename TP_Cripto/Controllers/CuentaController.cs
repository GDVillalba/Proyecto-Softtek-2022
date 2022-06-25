using System.Diagnostics;
using TP_Cripto.Models;
using TP_Cripto.Datos;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace TP_Cripto.Controllers
{
    public class CuentaController : Controller
    {
        ClienteDatos clienteDatos = new ClienteDatos();
        CuentaDatos cuentaDatos = new CuentaDatos();
        MonedaDatos monedaDatos = new MonedaDatos();
        MovimientoDatos movimientoDatos = new MovimientoDatos();

        public IActionResult Index()
        {
            if (HttpContext.Session.GetString("usuario") == null)
            {
                HttpContext.Session.SetInt32("idCliente", 0);
                HttpContext.Session.SetString("usuario", "");
            }

            //Get value from Session object.
            ViewBag.Usuario = HttpContext.Session.GetString("usuario");

            if (HttpContext.Session.GetString("usuario") != null && HttpContext.Session.GetString("usuario") != "")
            {
                var oLista = cuentaDatos.ListarCuentaCliente((int)Convert.ToInt32(HttpContext.Session.GetInt32("idCliente")));

                return View(oLista);
            }

            return View();

        }

        public IActionResult NuevaCuenta()
        {
            var oLista = monedaDatos.Listar();

            if (HttpContext.Session.GetString("usuario") == null)
            {
                HttpContext.Session.SetInt32("idCliente", 0);
                HttpContext.Session.SetString("usuario", "");
            }

            //Get value from Session object.
            ViewBag.Usuario = HttpContext.Session.GetString("usuario");

            #region ViewBag
            List<Microsoft.AspNetCore.Mvc.Rendering.SelectListItem> monedas = new List<SelectListItem>();

            foreach (var o in oLista)
            {
                monedas.Add(new SelectListItem() { Text = $"{o.Nombre}", Value = $"{o.Id}" });

            }

            ViewBag.Monedas = monedas;
            #endregion
            return View();
        }

        [HttpPost]
        public IActionResult NuevaCuenta(int idMoneda)
        {
            if (HttpContext.Session.GetString("usuario") == null)
            {
                HttpContext.Session.SetInt32("idCliente", 0);
                HttpContext.Session.SetString("usuario", "");
            }

            //Get value from Session object.
            ViewBag.Usuario = HttpContext.Session.GetString("usuario");

            try
            {
                idMoneda = Convert.ToInt32(Request.Form["TipoCuenta"]);

            }
            catch (Exception)
            {
                idMoneda = 0;
            }

            if (idMoneda == 0)
            {
                TempData["Message"] = "sin Moneda Invalida ";
                return RedirectToAction("NuevaCuenta");
            }

            return RedirectToAction("NuevaCuenta2", new { idMoneda = idMoneda }) ;
        }

        public IActionResult NuevaCuenta2(int idMoneda)
        {
            if (HttpContext.Session.GetString("usuario") == null)
            {
                HttpContext.Session.SetInt32("idCliente", 0);
                HttpContext.Session.SetString("usuario", "");
            }

            //Get value from Session object.
            ViewBag.Usuario = HttpContext.Session.GetString("usuario");

            ModelCuenta oCuenta = new ModelCuenta();
            oCuenta.IdTitular = (int)Convert.ToInt32(HttpContext.Session.GetInt32("idCliente"));
            oCuenta.IdMoneda = idMoneda;
            oCuenta.Moneda = monedaDatos.Obtener(idMoneda).Nombre;

            return View(oCuenta);
        }

        [HttpPost]
        public IActionResult NuevaCuenta2( ModelCuenta oCuenta)
        {
            if (HttpContext.Session.GetString("usuario") == null)
            {
                HttpContext.Session.SetInt32("idCliente", 0);
                HttpContext.Session.SetString("usuario", "");
            }

            //Get value from Session object.
            ViewBag.Usuario = HttpContext.Session.GetString("usuario");

            if (!ModelState.IsValid)
            {
                TempData["Message"] = new String("Model invalid ");
                return View(oCuenta);
            }

            if( oCuenta.IdMoneda == 3 && oCuenta.CBU_UUID.Length != 32 )
            {
                TempData["Minimo"] = "UUID necesita 32 valores";
                return View(oCuenta);
            }

            if (oCuenta.IdMoneda != 3 && oCuenta.CBU_UUID.Length != 22)
            {
                TempData["Minimo"] = "CBU necesita 22 valores";
                return View(oCuenta);
            }

            var respuesta = cuentaDatos.DisponibleCBU_UUID(oCuenta.CBU_UUID);

            if (respuesta)
            {
                if (cuentaDatos.CrearCuenta(oCuenta))
                {
                    TempData["success"] = "Cuenta succes Creada con Exito.";
                    return RedirectToAction("Index");
                }
                TempData["Message"] = new String("Error al vrear cuenta.");
                return View(oCuenta);
            }

            if(oCuenta.IdMoneda == 3 )
            {
                TempData["Message"] = new String("UUID ya registrado");
            }
            else
            {
                TempData["Message"] = new String("CBU ya registrado");
            }

            return View(oCuenta);
        }

        public IActionResult Depositar(int idCuenta)
        {
            if (HttpContext.Session.GetString("usuario") == null)
            {
                HttpContext.Session.SetInt32("idCliente", 0);
                HttpContext.Session.SetString("usuario", "");
            }

            //Get value from Session object.
            ViewBag.Usuario = HttpContext.Session.GetString("usuario");

            ModelCuenta oCuenta;
            oCuenta = cuentaDatos.Obtener(idCuenta);

            return View(oCuenta);
        }

        [HttpPost]
        public IActionResult Depositar(string deposito, int idCuenta)
        {
            Decimal credito = Decimal.Parse( deposito , System.Globalization.CultureInfo.GetCultureInfo("en-US"));
            if(credito <= 0)
            {
                TempData["success"] = "El deposito debe ser mayor a cero";
                return RedirectToAction("Depositar" , new { idCuenta = idCuenta } );
            }

            ModelCuenta oCuenta = new ModelCuenta();
            oCuenta = cuentaDatos.Obtener(idCuenta);

            ModelMovimiento oMovimiento = new ModelMovimiento();
            oMovimiento.IdCuenta = idCuenta;
            oMovimiento.Credito = credito;
            oMovimiento.Saldo = oCuenta.Saldo + credito;
            oMovimiento.Descripcion = $"Deposito {credito.ToString("0.00")} .";

            if(movimientoDatos.Depositar(oMovimiento))
            {
                TempData["success"] = "Depositado " + credito.ToString("0.00");
                return RedirectToAction("Index");
            }

            TempData["error"] = "Error al depositar ";

            return RedirectToAction("Depositar", new { idCuenta = idCuenta });
        }

        public IActionResult Extraer(int idCuenta)
        {
            if (HttpContext.Session.GetString("usuario") == null)
            {
                HttpContext.Session.SetInt32("idCliente", 0);
                HttpContext.Session.SetString("usuario", "");
            }

            //Get value from Session object.
            ViewBag.Usuario = HttpContext.Session.GetString("usuario");

            ModelCuenta oCuenta;
            oCuenta = cuentaDatos.Obtener(idCuenta);

            return View(oCuenta);
        }

        [HttpPost]
        public IActionResult Extraer(string extraccion, int idCuenta)
        {
            Decimal debito = Decimal.Parse(extraccion, System.Globalization.CultureInfo.GetCultureInfo("en-US"));
            if (debito <= 0)
            {
                TempData["success"] = "La extraccion debe ser mayor a cero";
                return RedirectToAction("Extraer", new { idCuenta = idCuenta });
            }

            ModelCuenta oCuenta = new ModelCuenta();
            oCuenta = cuentaDatos.Obtener(idCuenta);

            if (debito > oCuenta.Saldo )
            {
                TempData["success"] = "La extraccion no debe ser mayor al saldo en cuenta";
                return RedirectToAction("Extraer", new { idCuenta = idCuenta });
            }

            ModelMovimiento oMovimiento = new ModelMovimiento();
            oMovimiento.IdCuenta = idCuenta;
            oMovimiento.Debito = debito;
            oMovimiento.Saldo = oCuenta.Saldo - debito;
            oMovimiento.Descripcion = $"Extraccion {debito.ToString("0.00")} .";

            if (movimientoDatos.Extraer(oMovimiento))
            {
                TempData["success"] = "Extraido " + debito.ToString("0.00");
                return RedirectToAction("Index");
            }

            TempData["error"] = "Error al depositar ";

            return RedirectToAction("Extraer", new { idCuenta = idCuenta });
        }

        public IActionResult Transferir(int idCuenta)
        {
            if (HttpContext.Session.GetString("usuario") == null)
            {
                HttpContext.Session.SetInt32("idCliente", 0);
                HttpContext.Session.SetString("usuario", "");
            }

            //Get value from Session object.
            ViewBag.Usuario = HttpContext.Session.GetString("usuario");

            ModelCuenta oCuenta;
            oCuenta = cuentaDatos.Obtener(idCuenta);

            //Traigo todas las cuentas
            var oLista = cuentaDatos.ListarCuentaCliente((int)Convert.ToInt32(HttpContext.Session.GetInt32("idCliente")));

            //Creo un objeto SelectListItem para cargar las cuentas propias a las que puedo transferir
            #region ViewBag
            List<Microsoft.AspNetCore.Mvc.Rendering.SelectListItem> cuentas = new List<SelectListItem>();

            //Cargo todas las cuentas menos la cuenta origen de la transferencia
            foreach (var o in oLista)
            {
                if(o.Id != idCuenta)
                {
                cuentas.Add(new SelectListItem() { Text = $"{o.Descripcion}", Value = $"{o.Id}" });
                }

            }

            //Cargo en viewbag el SelectListItem para pasarlo a la vista
            ViewBag.Cuentas = cuentas;
            #endregion

            return View(oCuenta);
        }

        [HttpPost]
        public IActionResult Transferir(string monto, int idCuenta, int idCuentaDestino)
        {
            Decimal montoOrigen = Decimal.Parse(monto, System.Globalization.CultureInfo.GetCultureInfo("en-US"));

            //verifico que el monto sea mayor a cero
            if (montoOrigen <= 0)
            {
                TempData["success"] = "El monto debe ser mayor a cero";
                return RedirectToAction("Transferir", new { idCuenta = idCuenta });
            }

            ModelCuenta oCuentaOrigen = new ModelCuenta();
            oCuentaOrigen = cuentaDatos.Obtener(idCuenta);

            //verifico que la cuenta tenga saldo
            if (montoOrigen > oCuentaOrigen.Saldo)
            {
                TempData["success"] = "El monto no debe ser mayor al saldo en cuenta";
                return RedirectToAction("Transferir", new { idCuenta = idCuenta });
            }

            //verifico que la cuenta destino exista
            if ( idCuentaDestino == 0)
            {
                TempData["success"] = "Debe seleccionar una cuenta";
                return RedirectToAction("Transferir", new { idCuenta = idCuenta });
            }

            ModelCuenta oCuentaDestino = new ModelCuenta();
            oCuentaDestino = cuentaDatos.Obtener(idCuentaDestino);

           //convierto la moneda de origen a la de destino 
            Decimal montoDestino = ConvertirMoneda(montoOrigen, oCuentaOrigen.IdMoneda, oCuentaDestino.IdMoneda);

            //realizo la transferencia en la base de datos
            if (movimientoDatos.TransferenciaPropia(oCuentaOrigen,montoOrigen, oCuentaDestino, montoDestino))
            {
                TempData["success"] = "Transferencia " + montoOrigen.ToString("0.00") + "; destino: " + montoDestino;
                return RedirectToAction("Index");
            }

            //aviso si hay error
            TempData["error"] = "Error al transferir ";            

            return RedirectToAction("Transferir", new { idCuenta = idCuenta });
        }


        public IActionResult Movimientos(int idCuenta)
        {
            if (HttpContext.Session.GetString("usuario") == null)
            {
                HttpContext.Session.SetInt32("idCliente", 0);
                HttpContext.Session.SetString("usuario", "");
            }


            //Seteo valor desde el objeto Session.
            ViewBag.Usuario = HttpContext.Session.GetString("usuario");

            ModelCuenta oCuenta = cuentaDatos.Obtener(idCuenta);

            //paso la descripcion de la cuenta
            ViewBag.Cuenta = oCuenta.Descripcion;

            var oLista = movimientoDatos.ListarMovimientos(idCuenta);

            return View(oLista);
        }

        public IActionResult FaltaImplementar()
        {
            TempData["success"] = "Falta implementar Funcionalidad" ;

            return RedirectToAction("Index");
        }

        public Decimal ConvertirMoneda(Decimal monto, int idMonedaOrigen, int idMonedaDestino)
        {
            ModelMoneda monedaOrigen = monedaDatos.Obtener(idMonedaOrigen);
            ModelMoneda monedaDestino = monedaDatos.Obtener(idMonedaDestino);
            Decimal result = monto * monedaDestino.CotizacionEnUSD / monedaOrigen.CotizacionEnUSD;
            return result;
        }
      
    }
}
