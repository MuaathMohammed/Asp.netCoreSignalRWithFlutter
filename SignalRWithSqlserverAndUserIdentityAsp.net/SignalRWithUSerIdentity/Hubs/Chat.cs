using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.SignalR;
using SignalRWithUSerIdentity.Models;

namespace SignalRWithUSerIdentity.Hubs
{
    public class Chat : Hub
    {
        private readonly static ConnectionMapping<string> _connections =
          new ConnectionMapping<string>();
        public async Task SendMessage(Message message) {
       
                await Clients.Caller.SendAsync("receiveMessage", message);
                }

        public override async Task OnConnectedAsync()
        {
            await Groups.AddToGroupAsync(Context.ConnectionId, "f8b60d9c-61f2-49cf-8dd2-fd14142d0a75");
            await base.OnConnectedAsync();
        }
        public override async Task OnDisconnectedAsync(Exception exception)
        {
            await Groups.RemoveFromGroupAsync(Context.ConnectionId, "f8b60d9c-61f2-49cf-8dd2-fd14142d0a75");
            await base.OnDisconnectedAsync(exception);
        }
        public Task ThrowException()
        {
            throw new HubException("This error will be sent to the client!");
        }
    }
}
