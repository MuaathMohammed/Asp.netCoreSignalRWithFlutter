using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace SignalRWithUSerIdentity.Models
{
    public class AppUser: IdentityUser
    {
        [Column(TypeName = "nvarchar(150)")]
        public string FullName { get; set; }
        public AppUser()
        {
            Messages = new HashSet<Message>();
        }

        public virtual ICollection<Message> Messages { get; set; }

    }
}
