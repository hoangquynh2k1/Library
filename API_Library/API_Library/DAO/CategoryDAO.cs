using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using API_Library.Models;

namespace API_Library.DAO
{
    public class CategoryDAO
    {
        libraryContext db = new libraryContext();
        BookDAO Book = new BookDAO();
        public List<Category> Get()
        {
            return db.Categories.Where(e => e.Status == true).ToList();
        }
        public Category GetById(int id)
        {
            return db.Categories.Where(e => e.CategoryId == id && e.Status == true).ToList().First();
        }
        public bool Create(Category o)
        {
            o.CategoryId = (db.Categories.ToList().Last().CategoryId)++;
            if (o.Name != "")
            {
                db.Categories.Add(o);
                db.SaveChanges();
                return true;
            }
            return false;
        }
        public bool Update(Category o)
        {
            Category obj = GetById(o.CategoryId);
            obj.Name = o.Name;
            obj.Status = o.Status;
            db.SaveChanges();
            return true;
        }
        public bool Delete(int id)
        {
            Category obj = GetById(id);
            Book.DeleteByCategoryId(obj.CategoryId);
            obj.Status = false;
            db.SaveChanges();
            return true;
        }
    }
}
