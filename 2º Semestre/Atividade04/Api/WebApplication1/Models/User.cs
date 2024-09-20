using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace WebApplication1.Models;

public class User
{
    [Key]
    [JsonIgnore]
    public long Id { get; set; }

    public string Email { get; set; }

    public string Password { get; set; }
}