using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using SignalRWithUSerIdentity.Data;
using SignalRWithUSerIdentity.Hubs;
using SignalRWithUSerIdentity.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SignalRWithUSerIdentity.Controllers
{
    [Route("api/[controller]")]
    [ApiController]

    public class HubController : ControllerBase
    {
        private readonly ApplicationDbContext dbContext;
        private readonly IHubContext<Chat> _hubContext;
        
        public HubController(ApplicationDbContext context, IHubContext<Chat> hubContext)
      {
         dbContext = context;
         _hubContext = _hubContext;

      }
        [HttpGet("GetAll")]
        public IEnumerable<Message> GetAll()
        {

            return dbContext.Messages
                           .ToList();
        }
        //[Authorize]
        [HttpPost("Create")]
        public IActionResult Create([FromBody] Message postData)
        {
            if (postData == null)
            {
                return BadRequest();
            }


            dbContext.Messages.Add(postData);
            dbContext.SaveChanges();
            if (true == false)
            {
                _hubContext.Clients.All.SendAsync("SendMessage", postData);
            }
            else
            {
                return Ok();
            }
           

        }

    }
}
