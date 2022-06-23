using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace TP_Cripto.Models
{
    public class ModelMovimiento
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public int IdCuenta { get; set; }

        public Decimal Debito { get; set; }

        public Decimal Credito { get; set; }

        public Decimal Saldo { get; set; }

        [Required]
        public string? Descripcion { get; set; }

        [DisplayName("Fecha")]
        public DateOnly Fecha { get; set; }
    }
}

