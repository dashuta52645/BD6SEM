using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.IO;
using Microsoft.SqlServer.Server;
using System.Text;

[Serializable]
[Microsoft.SqlServer.Server.SqlUserDefinedType(Format.UserDefined, MaxByteSize = 8000)]
public struct Employee: INullable, IBinarySerialize
{
    private int id;
    private SqlString telephone;
    public int Id
    {
        get => id;
        set
        {
            if (value == 0)
            {
                throw new ArgumentException("Invalid Id value.");
            }
            id = value;
        }
    }

    public SqlString Telephone
    {
        get => telephone;
        set
        {
            if (value.IsNull)
            {
                throw new ArgumentException("Invalid telephone value.");
            }
            telephone = value;
        }
    }

    public bool IsNull { get; private set; }

    public override string ToString()
    {
        if (IsNull)
        {
            return "NULL";
        }
        else
        {
            var builder = new StringBuilder();
            builder.Append(Id);
            builder.Append(",");
            builder.Append(Telephone);
            return builder.ToString();
        }
    }


    public static Employee Null
    {
        get
        {
            var sn = new Employee
            {
                IsNull = true
            };
            return sn;
        }
    }

    public static Employee Parse(SqlString s)
    {
        if (s.IsNull)
            return Null;
        var sn = new Employee();
        var pairs = s.Value.Split(",".ToCharArray());
        sn.Id = int.Parse(pairs[0]);
        sn.Telephone = pairs[1];
        return sn;
    }

    public void Read(BinaryReader r)
    {
        Telephone = r.ReadString();
    }

    public void Write(BinaryWriter w)
    {
        w.Write(Telephone.ToString());
    }
}