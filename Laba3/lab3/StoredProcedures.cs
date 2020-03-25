using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;
using System.Runtime.InteropServices;
using System.IO;

public partial class StoredProcedures
    {
        [SqlProcedure]
        public static void GetEmployees(SqlDateTime dateStart, SqlDateTime dateEnd)
        {
            SqlConnection conn = new SqlConnection("Context Connection=true");
            conn.Open();
            SqlCommand sqlCmd = conn.CreateCommand();
            sqlCmd.Parameters.AddWithValue("@dateStart", dateStart);
            sqlCmd.Parameters.AddWithValue("@dateEnd", dateEnd);

        sqlCmd.CommandText = @"SELECT sum([Женат])as [Женат], sum([Замужем])as [Замужем], sum([Не замужем])as [Не замужем], sum([Не женат])as [Не женат] FROM (SELECT Id,FamilyStatus,DateOfReceipt FROM Employee WHERE DateOfReceipt BETWEEN @dateStart AND @dateEnd) E pivot(count(Id) for FamilyStatus in ([Женат], [Замужем], [Не замужем], [Не женат])) as pvt";
            SqlContext.Pipe.ExecuteAndSend(sqlCmd);
            conn.Close();
        }
    }
