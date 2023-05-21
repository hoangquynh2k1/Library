using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using API_Library.Models;

namespace API_Library.DAO
{
    public class BorrowingDAO
    {
        libraryContext db = new libraryContext();
        public BorrowingDAO() { }
        public List<Borrowing> Get()
        {
            return db.Borrowings.Where(e => e.Status == true).ToList();
        }
        public Borrowing GetById(int id)
        {
            return db.Borrowings.Where(e => e.BorrowingId == id && e.Status == true).ToList().First();
        }
        public bool Create(Borrowing o)
        {
            o.BorrowingId = db.Borrowings.ToList().Last().BorrowingId++;
            if (o.BorrowerId > 0)
            {
                db.Borrowings.Add(o);
                db.SaveChanges();
                return true;
            }
            return false;
        }
        public bool Update(Borrowing o)
        {
            Borrowing obj = GetById(o.BorrowingId);
            obj.BorrowerId = o.BorrowerId;
            obj.BorrowedDate = o.BorrowedDate;
            obj.AppointmentDate = o.AppointmentDate;
            obj.Status = o.Status;
            obj.StaffId= o.StaffId;
            db.SaveChanges();
            return true;
        }
        public bool Delete(int id)
        {
            Borrowing obj = GetById(id);
            obj.Status = false;
            db.SaveChanges();
            return true;
        }

    }
}
