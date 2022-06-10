using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace TP_Cripto.Models
{
    public class ModelMoneda
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public string? Nombre { get; set; }

        [Required]
        public decimal CotizacionEnUSD { get; set; }
    }
}
