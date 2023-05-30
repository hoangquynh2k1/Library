using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using API_Library.Models;
using API_Library.DAO;
using API_Library.Entities;

namespace API_Library.BUS
{
    public class BorrowingBUS: BorrowingDAO
    {
        BorrowerDAO borrowerDAO = new BorrowerDAO();
        BorrowingDetailDAO borrowingDetailDAO = new BorrowingDetailDAO();

        public List<BorrowingEntity> GetData()
        {
            List<Borrowing> borrowing = Get();
            List<BorrowingEntity> list = new List<BorrowingEntity>();
            for(int i =0;i<borrowing.Count;i++)
            {
                Borrower borrower = borrowerDAO.GetById((int)borrowing[i].BorrowerId);
                List<BorrowingDetail> listDetail = borrowingDetailDAO.GetByBorrowingId(
                    (int)borrowing[i].BorrowingId);
                BorrowingEntity entity = new BorrowingEntity();
                entity.BorrowerId = borrower.BorrowerId;
                entity.BorrowingId = borrowing[i].BorrowingId;
                entity.BorrowedDate = borrowing[i].BorrowedDate;
                entity.StaffId = borrowing[i].StaffId;
                entity.AppointmentDate = borrowing[i].AppointmentDate;
                entity.Status = borrowing[i].Status;
                entity.Details = listDetail;
                entity.Name = borrower.Name;
                entity.NotificationStatus= borrowing[i].NotificationStatus;
                entity.BorrowStatus = CheckBorrow(entity);
                list.Add(entity);
            }
            return list;
        }
        private bool CheckBorrow(BorrowingEntity e)
        {
            for(int i =0;i< e.Details.Count;i++)
            {
                if (e.Details[i].ReturnDate == null)
                    return false;
            }
            return true;
        }
    }
}
