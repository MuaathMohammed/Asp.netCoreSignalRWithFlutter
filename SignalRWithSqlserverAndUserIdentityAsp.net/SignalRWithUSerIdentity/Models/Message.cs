using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace SignalRWithUSerIdentity.Models
{
    public class Message
    {
        public int id {
            get; set; }
        public string UserName {
            get; set; }
        public string Text {
            get; set; }
        public DateTime When {
            get; set; }
        [ForeignKey("Id")]
        public string UserId
        {
            get; set;
        }
        public virtual AppUser Sender { get; set; }

        public Message()
        {
            When = DateTime.Now;
        }
    }
}
