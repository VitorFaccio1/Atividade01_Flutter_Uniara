using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers;

[ApiController]
[Route("[controller]")]
public class UsersController : Controller
{
    private readonly WebApplication1Context _context;

    public UsersController(WebApplication1Context context)
    {
        _context = context;
    }

    [HttpPost("create")]
    public async Task<IActionResult> Create([Bind("Id,Email,Password")] User user)
    {
        if (!ModelState.IsValid)
            return BadRequest(new { message = "Insira os dados corretamente!" });

        var userExists = await _context.Users.AnyAsync(userDB => userDB.Email.Equals(user.Email));

        if (userExists)
            return Conflict(new { message = "Já existe usuário com esse e-mail cadastrado!" });

        _context.Add(user);

        await _context.SaveChangesAsync();

        return Created("", user);
    }

    [HttpPost("login")]
    public async Task<IActionResult> Login([Bind("Email,Password")] User user)
    {
        if (!ModelState.IsValid)
            return BadRequest(new { message = "Insira os dados corretamente!" });

        var userExists = await _context.Users.AnyAsync(userDB => userDB.Email.Equals(user.Email) && userDB.Password.Equals(user.Password));

        if (!userExists)
            return NotFound(new { message = "Usuário não encontrado!" });

        return Ok();
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetUserById(Guid id)
    {
        var user = await _context.Users.FindAsync(id);

        if (user == null)
            return NotFound();

        return Ok(user);
    }
}