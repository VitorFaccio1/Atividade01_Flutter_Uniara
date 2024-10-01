using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;

namespace WebApplication1.Models;

public class Store
{
    public Store(string name, string type, string cep, string logradouro, string bairro, string localidade, string uf)
    {
        Name = name;
        Type = type;
        Cep = cep;
        Logradouro = logradouro;
        Bairro = bairro;
        Localidade = localidade;
        Uf = uf;
    }

    [Key]
    [JsonIgnore]
    public long Id { get; set; }

    public string Name { get; set; }

    public string Type { get; set; }

    public string Cep { get; set; }

    public string Logradouro { get; set; }

    public string Bairro { get; set; }

    public string Localidade { get; set; }

    public string Uf { get; set; }
}