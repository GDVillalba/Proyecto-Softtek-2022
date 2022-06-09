using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using TP_Cripto.Models;
using TP_Cripto.Datos;

namespace TP_Cripto.Controllers
{
    public class CuentaController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
