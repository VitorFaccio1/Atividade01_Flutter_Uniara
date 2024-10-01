using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers;

[ApiController]
[Route("[controller]")]
public class StoresController : Controller
{
    private readonly WebApplication1Context _context;

    public StoresController(WebApplication1Context context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<IActionResult> GetStores()
    {
        return Ok(await _context.Stores.ToListAsync());
    }

    [HttpPost("register")]
    public async Task<IActionResult> Register(Store store)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);

        _context.Stores.Add(store);

        await _context.SaveChangesAsync();

        return Created("", store);
    }
}