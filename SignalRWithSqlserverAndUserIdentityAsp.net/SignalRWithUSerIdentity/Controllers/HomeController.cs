using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Microsoft.IdentityModel.Tokens;
using SignalRWithUSerIdentity.Data;
using SignalRWithUSerIdentity.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using TestUserAuthApi.Models;

namespace SignalRWithUSerIdentity.Controllers
{
    [Authorize]
    public class HomeController : Controller
    {
        // private readonly ILogger<HomeController> _logger;
        private readonly UserManager<AppUser> _userManager;
        //private readonly ILogger<HomeController> _logger;
        private readonly ApplicationDbContext _dbContext;
     //   private SignInManager<AppUser> _singInManager;



        //private readonly UserManager<AppUser> _userManager;
        //public HomeController(ILogger<HomeController> logger, ApplicationDbContext dbContext, UserManager<AppUser> userManager)
        //{
        //    _logger = logger;
        //    _dbContext = dbContext;
        //    _userManager = userManager;
        //}
        public HomeController( ApplicationDbContext dbContext, UserManager<AppUser> userManager)
        {
            //  _logger = logger;
            
            _dbContext = dbContext;
            _userManager = userManager;
          //  _singInManager = signInManager;
        }

        public async Task<IActionResult> Index()
        {
          
            var currenyUser = await _userManager.GetUserAsync(User);
            if (User.Identity.IsAuthenticated)
            {
                ViewBag.CurrentUserName = currenyUser.UserName;

            }
            var message = await _dbContext.Messages.ToListAsync();

            return View(message);
        }
        //[HttpPost]
        //[Route("Register")]
        ////POST : /api/ApplicationUser/Register
        //public async Task<Object> PostApplicationUser(ApplicationUserModel model)
        //{
        //    model.Role = "Customer";
        //    var applicationUser = new AppUser()
        //    {
        //        UserName = model.UserName,
        //        Email = model.Email                
        //    };

        //    try
        //    {
        //        var result = await _userManager.CreateAsync(applicationUser, model.Password);
        //        await _userManager.AddToRoleAsync(applicationUser, model.Role);
        //        return Ok(result);
        //    }
        //    catch (Exception ex)
        //    {

        //        throw ex;
        //    }
        //}

        //[HttpPost]
        //[Route("Login")]
        ////POST : /api/ApplicationUser/Login
        //public async Task<IActionResult> Login(LoginModel model)
        //{
        //    var user = await _userManager.FindByNameAsync(model.UserName);
        //    if (user != null && await _userManager.CheckPasswordAsync(user, model.Password))
        //    {
        //        //Get role assigned to the user
        //        var role = await _userManager.GetRolesAsync(user);
        //        IdentityOptions _options = new IdentityOptions();

        //        var tokenDescriptor = new SecurityTokenDescriptor
        //        {
        //            Subject = new ClaimsIdentity(new Claim[]
        //            {
        //                new Claim("UserID",user.Id.ToString()),
        //                new Claim(_options.ClaimsIdentity.RoleClaimType,role.FirstOrDefault())
        //            }),
        //            Expires = DateTime.UtcNow.AddDays(1),
        //            SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(Encoding.UTF8.GetBytes("1234567890123456")), SecurityAlgorithms.HmacSha256Signature)
        //        };
        //        var tokenHandler = new JwtSecurityTokenHandler();
        //        var securityToken = tokenHandler.CreateToken(tokenDescriptor);
        //        var token = tokenHandler.WriteToken(securityToken);
        //        return Ok(new { token });
        //    }
        //    else
        //        return BadRequest(new { message = "Username or password is incorrect." });
        //}
        //[AllowAnonymous]
        //[Route("login")]
        //[HttpPost]
        //public IActionResult Login( userModel)
        //{
        //    if (string.IsNullOrEmpty(userModel.UserName) || string.IsNullOrEmpty(userModel.Password))
        //    {
        //        return (RedirectToAction("Error"));
        //    }

        //    IActionResult response = Unauthorized();
        //    var validUser = GetUser(userModel);

        //    if (validUser != null)
        //    {
        //        generatedToken = _tokenService.BuildToken(_config["Jwt:Key"].ToString(), _config["Jwt:Issuer"].ToString(),
        //        validUser);

        //        if (generatedToken != null)
        //        {
        //            HttpContext.Session.SetString("Token", generatedToken);
        //            return RedirectToAction("MainWindow");
        //        }
        //        else
        //        {
        //            return (RedirectToAction("Error"));
        //        }
        //    }
        //    else
        //    {
        //        return (RedirectToAction("Error"));
        //    }
        //}
        //private UserManager<AppUser> GetUser(UserModel userModel)
        //{
        //    //Write your code here to authenticate the user
        //    userModel.UserName = User.Identity.Name;
        //    return _userManager.GetUserAsync(User);
        //}
        public async Task<IActionResult> Create(Message message)
        {
            if (ModelState.IsValid)
            {
                message.UserName = User.Identity.Name;
                var sender = await _userManager.GetUserAsync(User);
                message.UserId = sender.Id;
                await _dbContext.Messages.AddAsync(message);
                await _dbContext.SaveChangesAsync();
                return Ok();
            }
            return Error();
        }
            public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
