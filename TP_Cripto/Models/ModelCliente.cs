using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace TP_Cripto.Models
{
    public class ModelCliente
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public string? Usuario { get; set; }

        [Required]
        public string? Clave { get; set; }

        [Required]
        public string? Nombre { get; set; }

        [Required]
        public string? Mail { get; set; }

        [Required]
        public string? Telefono { get; set; }

        [DisplayName("Fecha de alta")]
        public DateOnly? FechaAlta { get; set; }
    }
}
