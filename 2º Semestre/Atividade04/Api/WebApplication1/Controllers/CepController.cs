using Microsoft.AspNetCore.Mvc;

namespace WebApplication1.Controllers;

[ApiController]
[Route("[controller]")]
public class CepController : ControllerBase
{
    private readonly HttpClient _client;

    public CepController(HttpClient client)
    {
        _client = client;
    }

    [HttpGet("{cep}")]
    public async Task<IActionResult> GetAddressByCep(string cep)
    {
        cep = cep.Replace(".", "").Replace("-", "").Trim();

        var response = await _client.GetAsync($"https://viacep.com.br/ws/{cep}/json/");

        if (!response.IsSuccessStatusCode)
            return NotFound("CEP não encontrado.");

        var addressData = await response.Content.ReadAsStringAsync();
        return Ok(addressData);
    }
}