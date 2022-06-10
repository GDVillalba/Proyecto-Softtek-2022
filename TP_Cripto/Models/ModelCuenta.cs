using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace TP_Cripto.Models
{
    public class ModelCuenta
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public int IdTitular { get; set; }

        [Required]
        public int IdMoneda { get; set; }
        
        public String? Moneda { get; set; }

        [Required]
        public String? CBU_UUID { get; set; }

        public String? Alias { get; set; }

        [Required]
        public int NumeroCuenta { get; set; }

        [Required]
        public Decimal Saldo { get; set; }

        [Required]
        public string? Descripcion { get; set; }

        [DisplayName("Fecha de alta")]
        public DateOnly FechaAlta { get; set; }
    }
}
