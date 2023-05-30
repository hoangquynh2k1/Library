using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using API_Library.BUS;
using API_Library.Models;
using System.Linq;
using System;
using API_Library.Entities;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace API_Library.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class BorrowingController : ControllerBase
    {
        BorrowingBUS db = new BorrowingBUS();
        // GET: api/<AccountController>
        [HttpGet]
        public IEnumerable<Borrowing> Get()
        {
            return db.Get();
        }

        // GET api/<AccountController>/5
        [HttpGet("{id}")]
        public Borrowing Get(int id)
        {
            return db.GetById(id);
        }

        [HttpPost]
        public IActionResult Search([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                int? dropdownId = null;
                string loc = "";
                if (formData.Keys.Contains("loc") && !string.IsNullOrEmpty(Convert.ToString(formData["loc"])))
                { loc = formData["loc"].ToString(); }
                if (formData.Keys.Contains("dropdown") && !string.IsNullOrEmpty(Convert.ToString(formData["dropdown"])))
                { dropdownId = int.Parse(formData["dropdown"].ToString()); }
                List<BorrowingEntity> list = db.GetData().Where(x => x.Name.Contains(loc)).ToList();
                switch(dropdownId)
                {
                    case 0:
                        break;
                    case 1:
                        list = list.Where(x => x.BorrowStatus == false).ToList(); break;
                    case 2:
                        list = list.Where(x => x.BorrowStatus == true).ToList(); break;
                    case 3:
                        list = list.Where(x => x.Status == true).ToList();
                        break;
                    case 4:
                        list = list.Where(x => x.Status == false).ToList();
                        break;
                }    
                long total = list.Count();
                list = list.
                    Skip(pageSize * (page - 1)).OrderBy(x => x.BorrowStatus).Take(pageSize).ToList();
                return Ok(
                           new DataSearch
                           {
                               page = page,
                               totalItem = total,
                               pageSize = pageSize,
                               data = list
                           }
                         );
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        // POST api/<AccountController>
        [HttpPost]
        public bool Post(Borrowing o)
        {
            return db.Create(o);
        }

        // PUT api/<AccountController>/5
        [HttpPut("{id}")]
        public bool Put(Borrowing o)
        {
            return db.Update(o);
        }

        // DELETE api/<AccountController>/5
        [HttpDelete("{id}")]
        public bool Delete(int id)
        {
            return db.Delete(id);
        }
    }
}
