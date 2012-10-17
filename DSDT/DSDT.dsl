/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20090521
 *
 * Disassembly of DSDT.aml, Tue Apr 26 12:47:27 2011
 *
 *
 * Original Table Header:
 *     Signature        "DSDT"
 *     Length           0x00006ADD (27357)
 *     Revision         0x02
 *     Checksum         0xBD
 *     OEM ID           "INT430"
 *     OEM Table ID     "SYSFexxx"
 *     OEM Revision     0x00001001 (4097)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20080926 (537397542)
 */
DefinitionBlock ("DSDT.aml", "DSDT", 2, "INT430", "SYSFexxx", 0x00001001)
{
    External (NPSS, IntObj)

    Name (VERS, Package (0x03)
    {
        "Project: DELL M09    ", 
        "Date: 01/01/2007", 
        "Ver: 1.00.00"
    })
    Method (TO01, 1, NotSerialized)
    {
        Store (SizeOf (Arg0), Local0)
        If (LEqual (ObjectType (Arg0), 0x02))
        {
            Increment (Local0)
        }

        Name (OBUF, Buffer (Local0) {})
        Store (Arg0, OBUF)
        If (LEqual (ObjectType (Arg0), 0x02))
        {
            Decrement (Local0)
            Store (Zero, Index (OBUF, Local0))
        }

        Return (OBUF)
    }

    Method (TO02, 3, NotSerialized)
    {
        Store (Arg0, Local0)
        If (LGreaterEqual (Arg0, 0x0A))
        {
            Divide (Arg0, 0x0A, Local0, Local1)
            Store (TO02 (Local1, Arg1, Arg2), Arg2)
        }

        Add (Local0, 0x30, Local0)
        Store (Local0, Index (Arg1, Arg2))
        Increment (Arg2)
        Return (Arg2)
    }

    Method (TO03, 1, NotSerialized)
    {
        Name (LBUF, Buffer (0x20) {})
        Store (TO02 (Arg0, LBUF, Zero), Local0)
        Store (Zero, Index (LBUF, Local0))
        Increment (Local0)
        Name (OBUF, Buffer (Local0) {})
        Store (LBUF, OBUF)
        Return (OBUF)
    }

    Method (TO04, 3, NotSerialized)
    {
        CreateByteField (Arg0, Arg1, VAL)
        Store (Arg2, VAL)
    }

    Name (MISC, Buffer (0x08)
    {
        /* 0000 */    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    })
    CreateByteField (MISC, Zero, MIS0)
    CreateByteField (MISC, One, MIS1)
    CreateByteField (MISC, 0x02, MIS2)
    CreateByteField (MISC, 0x03, MIS3)
    CreateByteField (MISC, 0x04, MIS4)
    CreateByteField (MISC, 0x05, MIS5)
    CreateByteField (MISC, 0x06, MIS6)
    CreateByteField (MISC, 0x07, MIS7)
    Scope (\)
    {
        OperationRegion (RCRB, SystemMemory, 0xFED18000, 0x4000)
        Field (RCRB, DWordAcc, Lock, Preserve)
        {
                    Offset (0x1000), 
                    Offset (0x3000), 
                    Offset (0x3404), 
            HPAS,   2, 
                ,   5, 
            HPAE,   1, 
                    Offset (0x3418), 
                ,   1, 
            PATD,   1, 
            SATD,   1, 
            SMBD,   1, 
            HDAD,   1, 
            A97D,   1, 
                    Offset (0x341A), 
            RPD1,   1, 
            RPD2,   1, 
            RPD3,   1, 
            RPD4,   1, 
            RPD5,   1, 
            RPD6,   1
        }
    }

    Scope (_SB)
    {
        Method (DBEN, 0, NotSerialized)
        {
        }

        OperationRegion (SMIR, SystemIO, 0xB2, 0x02)
        Field (SMIR, ByteAcc, NoLock, Preserve)
        {
            SMIC,   8, 
            SMID,   8
        }

        OperationRegion (SMR2, SystemIO, 0x86, One)
        Field (SMR2, ByteAcc, NoLock, Preserve)
        {
            SMIA,   8
        }

        OperationRegion (SMR3, SystemIO, 0x66, One)
        Field (SMR3, ByteAcc, NoLock, Preserve)
        {
                ,   2, 
            MECI,   1, 
                    Offset (0x01)
        }
    }

    Mutex (SMIX, 0x01)
    Method (SMI, 2, NotSerialized)
    {
        Acquire (SMIX, 0xFFFF)
        While (LEqual (\_SB.MECI, Zero)) {}
        Store (Arg1, \_SB.SMIA)
        Store (Arg0, \_SB.SMIC)
        Store (\_SB.SMIC, Local0)
        While (LNotEqual (Local0, Zero))
        {
            Store (\_SB.SMIC, Local0)
        }

        Store (\_SB.SMIA, Local1)
        Release (SMIX)
        Return (Local1)
    }

    Name (SXX0, Buffer (0x0100) {})
    Name (SXX1, Buffer (0x08) {})
    CreateWordField (SXX1, Zero, SXX2)
    CreateWordField (SXX1, 0x04, SXX3)
    Method (SX10, 0, NotSerialized)
    {
        Acquire (SMIX, 0xFFFF)
        Store (Zero, SXX2)
    }

    Method (SX30, 1, NotSerialized)
    {
        Store (SXX2, Local0)
        Increment (Local0)
        If (LLessEqual (Local0, SizeOf (SXX0)))
        {
            CreateByteField (SXX0, SXX2, SX20)
            Store (Arg0, SX20)
            Store (Local0, SXX2)
        }
    }

    Method (SX31, 1, NotSerialized)
    {
        Store (SXX2, Local0)
        Add (Local0, 0x02, Local0)
        If (LLessEqual (Local0, SizeOf (SXX0)))
        {
            CreateWordField (SXX0, SXX2, SX21)
            Store (Arg0, SX21)
            Store (Local0, SXX2)
        }
    }

    Method (SX32, 1, NotSerialized)
    {
        Store (SXX2, Local0)
        Add (Local0, 0x04, Local0)
        If (LLessEqual (Local0, SizeOf (SXX0)))
        {
            CreateDWordField (SXX0, SXX2, SX22)
            Store (Arg0, SX22)
            Store (Local0, SXX2)
        }
    }

    Method (SX33, 2, NotSerialized)
    {
        If (LLess (Arg1, SizeOf (Arg0)))
        {
            CreateByteField (Arg0, Arg1, SX20)
            SX30 (SX20)
        }
    }

    Method (SX34, 2, NotSerialized)
    {
        Store (Zero, Local0)
        While (LLess (Local0, Arg1))
        {
            SX33 (Arg0, Local0)
            Increment (Local0)
        }
    }

    Method (SXX6, 2, NotSerialized)
    {
        While (LEqual (\_SB.MECI, Zero)) {}
        Store (Arg1, \_SB.SMIA)
        Store (Arg0, \_SB.SMIC)
        Store (\_SB.SMIC, Local0)
        While (LNotEqual (Local0, Zero))
        {
            Store (\_SB.SMIC, Local0)
        }

        Return (\_SB.SMIA)
    }

    Method (SXX5, 2, NotSerialized)
    {
        If (LLess (Arg1, SizeOf (Arg0)))
        {
            CreateByteField (Arg0, Arg1, SX20)
            SXX6 (0x7C, SX20)
        }
    }

    Method (SXX4, 0, NotSerialized)
    {
        SXX6 (0x7B, Zero)
        Store (Zero, Local0)
        While (LLess (Local0, SXX2))
        {
            SXX5 (SXX0, Local0)
            Increment (Local0)
        }
    }

    Method (SXX8, 2, NotSerialized)
    {
        If (LLess (Arg1, SizeOf (Arg0)))
        {
            CreateByteField (Arg0, Arg1, SX20)
            Store (SXX6 (0x7D, Zero), SX20)
        }
    }

    Method (SXX7, 0, NotSerialized)
    {
        Store (Zero, Local0)
        While (LLess (Local0, SXX3))
        {
            Add (SXX2, Local0, Local1)
            SXX8 (SXX0, Local1)
            Increment (Local0)
        }
    }

    Method (SX11, 0, NotSerialized)
    {
        SXX4 ()
        Store (SXX6 (0x79, Zero), SXX3)
        Add (SXX2, SXX3, Local0)
        If (LLess (SizeOf (SXX0), Local0))
        {
            Store (SizeOf (SXX0), Local0)
            Subtract (Local0, SXX2, Local0)
            Store (Local0, SXX3)
        }

        SXX7 ()
    }

    Method (SX40, 0, NotSerialized)
    {
        Store (SXX2, Local0)
        Increment (Local0)
        If (LLessEqual (Local0, SizeOf (SXX0)))
        {
            CreateByteField (SXX0, SXX2, SX20)
            Store (Local0, SXX2)
            Return (SX20)
        }

        Return (Zero)
    }

    Method (SX41, 0, NotSerialized)
    {
        Store (SXX2, Local0)
        Add (Local0, 0x02, Local0)
        If (LLessEqual (Local0, SizeOf (SXX0)))
        {
            CreateWordField (SXX0, SXX2, SX21)
            Store (Local0, SXX2)
            Return (SX21)
        }

        Return (Zero)
    }

    Method (SX42, 0, NotSerialized)
    {
        Store (SXX2, Local0)
        Add (Local0, 0x04, Local0)
        If (LLessEqual (Local0, SizeOf (SXX0)))
        {
            CreateDWordField (SXX0, SXX2, SX22)
            Store (Local0, SXX2)
            Return (SX22)
        }

        Return (Zero)
    }

    Method (SX43, 2, NotSerialized)
    {
        If (LLess (Arg1, SizeOf (Arg0)))
        {
            CreateByteField (Arg0, Arg1, SX20)
            Store (SX40 (), SX20)
        }
    }

    Method (SX44, 2, NotSerialized)
    {
        Store (Zero, Local0)
        While (LLess (Local0, Arg1))
        {
            SX43 (Arg0, Local0)
            Increment (Local0)
        }
    }

    Method (SX45, 0, NotSerialized)
    {
        Store (SX40 (), Local0)
        Name (SX23, Buffer (Local0) {})
        SX44 (SX23, Local0)
        Return (SX23)
    }

    Method (SX12, 0, NotSerialized)
    {
        Release (SMIX)
    }

    Method (PNPQ, 1, NotSerialized)
    {
        SX10 ()
        SX30 (Zero)
        SX30 (0x02)
        SX30 (Arg0)
        SX11 ()
        Store (SX40 (), Local0)
        SX12 ()
        Return (Local0)
    }

    Method (PNPD, 1, NotSerialized)
    {
        SX10 ()
        SX30 (Zero)
        SX30 (0x03)
        SX30 (Arg0)
        SX11 ()
        SX12 ()
    }

    Method (PNPG, 1, NotSerialized)
    {
        SX10 ()
        SX30 (Zero)
        SX30 (Zero)
        SX30 (Arg0)
        SX11 ()
        Name (PGET, Buffer (SXX3) {})
        SX44 (PGET, SXX3)
        SX12 ()
        Return (PGET)
    }

    Method (PNPS, 2, NotSerialized)
    {
        SX10 ()
        SX30 (Zero)
        SX30 (One)
        SX30 (Arg0)
        SX34 (Arg1, SizeOf (Arg1))
        SX11 ()
        SX12 ()
    }

    Method (PSW, 2, NotSerialized)
    {
        SX10 ()
        SX30 (0x06)
        SX30 (Arg0)
        SX30 (Arg1)
        SX11 ()
        SX12 ()
    }

    Method (DSS, 2, NotSerialized)
    {
        SX10 ()
        SX30 (0x08)
        SX30 (Arg0)
        SX32 (Arg1)
        SX11 ()
        SX12 ()
    }

    Method (GMEM, 0, NotSerialized)
    {
        SX10 ()
        SX30 (0x07)
        SX11 ()
        Store (SX42 (), Local0)
        SX12 ()
        Return (Local0)
    }

    Method (G4GB, 0, NotSerialized)
    {
        SX10 ()
        SX30 (0x1B)
        SX11 ()
        Store (SX42 (), Local0)
        SX12 ()
        Return (Local0)
    }

    Method (SMMB, 0, NotSerialized)
    {
        SX10 ()
        SX30 (0x11)
        SX11 ()
        Store (SX42 (), Local0)
        SX12 ()
        Return (Local0)
    }

    Method (GPXB, 0, NotSerialized)
    {
        SX10 ()
        SX30 (0x1A)
        SX11 ()
        Store (SX42 (), Local0)
        SX12 ()
        Return (Local0)
    }

    Method (GORL, 0, NotSerialized)
    {
        SX10 ()
        SX30 (0x09)
        SX11 ()
        Store (SX42 (), Local0)
        SX12 ()
        Return (Local0)
    }

    Mutex (WMIS, 0x01)
    Name (WM00, Zero)
    Method (WM02, 0, NotSerialized)
    {
        SX10 ()
        SX30 (0x15)
        SX11 ()
        Store (SX42 (), WM00)
        SX12 ()
    }

    Method (WM03, 3, NotSerialized)
    {
        OperationRegion (WWPR, SystemMemory, Arg0, One)
        Field (WWPR, ByteAcc, Lock, Preserve)
        {
            MEMW,   8
        }

        CreateByteField (Arg1, Arg2, WVAL)
        Store (WVAL, MEMW)
    }

    Method (WM05, 3, NotSerialized)
    {
        OperationRegion (WWPR, SystemMemory, Arg0, 0x04)
        Field (WWPR, ByteAcc, Lock, Preserve)
        {
            MW32,   32
        }

        CreateDWordField (Arg1, Arg2, WVAL)
        Store (WVAL, MW32)
    }

    Method (WM04, 3, NotSerialized)
    {
        OperationRegion (WRPR, SystemMemory, Arg0, One)
        Field (WRPR, ByteAcc, Lock, Preserve)
        {
            MEMR,   8
        }

        CreateByteField (Arg1, Arg2, WVAL)
        Store (MEMR, WVAL)
        Store (Zero, MEMR)
    }

    Method (WM06, 3, NotSerialized)
    {
        OperationRegion (WRPR, SystemMemory, Arg0, 0x04)
        Field (WRPR, ByteAcc, Lock, Preserve)
        {
            MR32,   32
        }

        CreateDWordField (Arg1, Arg2, WVAL)
        Store (MR32, WVAL)
        Store (Zero, MR32)
    }

    Method (WM07, 3, NotSerialized)
    {
        If (LLessEqual (Arg1, 0x1000))
        {
            Store (WM00, Local0)
            Store (Zero, Local1)
            While (LLess (Local1, Arg1))
            {
                WM05 (Local0, Arg0, Local1)
                Add (Local0, 0x04, Local0)
                Add (Local1, 0x04, Local1)
            }

            SXX6 (Arg2, Zero)
            Store (WM00, Local0)
            Store (Zero, Local1)
            While (LLess (Local1, Arg1))
            {
                WM06 (Local0, Arg0, Local1)
                Add (Local0, 0x04, Local0)
                Add (Local1, 0x04, Local1)
            }
        }

        Return (Arg0)
    }

    Method (WMI, 3, NotSerialized)
    {
        Acquire (WMIS, 0xFFFF)
        If (LEqual (WM00, Zero))
        {
            WM02 ()
        }

        WM07 (Arg0, Arg1, Arg2)
        Release (WMIS)
        Return (Arg0)
    }

    Name (W98S, "Microsoft Windows")
    Name (NT5S, "Microsoft Windows NT")
    Name (WINM, "Microsoft WindowsME: Millennium Edition")
    Name (WXP, "Windows 2001")
    Name (WLG, "Windows 2006")
    Name (WIN7, "Windows 2009")
    Name (LNX, "Linux")
    Method (GETC, 2, NotSerialized)
    {
        CreateByteField (Arg0, Arg1, TCHR)
        Return (TCHR)
    }

    Method (STRE, 2, NotSerialized)
    {
        Name (STR1, Buffer (0x50) {})
        Name (STR2, Buffer (0x50) {})
        Store (Arg0, STR1)
        Store (Arg1, STR2)
        Store (Zero, Local0)
        Store (One, Local1)
        While (Local1)
        {
            Store (GETC (STR1, Local0), Local1)
            Store (GETC (STR2, Local0), Local2)
            If (LNotEqual (Local1, Local2))
            {
                Return (Zero)
            }

            Increment (Local0)
        }

        Return (One)
    }

    Method (OSID, 0, NotSerialized)
    {
        If (LEqual (MIS3, Zero))
        {
            Store (One, MIS3)
            If (CondRefOf (\_OSI, Local0))
            {
                If (_OSI (WXP))
                {
                    Store (0x10, MIS3)
                }

                If (_OSI (WLG))
                {
                    Store (0x20, MIS3)
                }

                If (_OSI (WIN7))
                {
                    Store (0x80, MIS3)
                }

                If (_OSI (LNX))
                {
                    Store (0x40, MIS3)
                }
            }
            Else
            {
                If (STRE (_OS, W98S))
                {
                    Store (0x02, MIS3)
                }

                If (STRE (_OS, NT5S))
                {
                    Store (0x08, MIS3)
                }

                If (STRE (_OS, WINM))
                {
                    Store (0x04, MIS3)
                }
            }
        }

        Return (MIS3)
    }

    Method (SOST, 0, NotSerialized)
    {
        SX10 ()
        SX30 (0x0A)
        OSID ()
        SX30 (MIS3)
        SX11 ()
        SX12 ()
    }

    Name (CRS0, Buffer (0x0192) {})
    CreateWordField (CRS0, 0x0190, CRS1)
    Method (CRS3, 0, NotSerialized)
    {
        Store (Zero, CRS1)
    }

    Method (CRS4, 1, NotSerialized)
    {
        CreateByteField (CRS0, CRS1, CRS2)
        Store (Arg0, CRS2)
        Increment (CRS1)
    }

    Method (CRS5, 1, NotSerialized)
    {
        CreateWordField (CRS0, CRS1, CRS2)
        Store (Arg0, CRS2)
        Increment (CRS1)
        Increment (CRS1)
    }

    Method (CRS6, 1, NotSerialized)
    {
        CreateDWordField (CRS0, CRS1, CRS2)
        Store (Arg0, CRS2)
        Add (CRS1, 0x04, CRS1)
    }

    Method (CRS7, 1, NotSerialized)
    {
        CreateQWordField (CRS0, CRS1, CRS2)
        Store (Arg0, CRS2)
        Add (CRS1, 0x08, CRS1)
    }

    Method (CR_0, 3, NotSerialized)
    {
        CRS4 (0x86)
        CRS5 (0x09)
        CRS4 (Arg0)
        CRS6 (Arg1)
        CRS6 (Arg2)
    }

    Method (CR_1, 4, NotSerialized)
    {
        CRS4 (0x47)
        CRS4 (One)
        CRS5 (Arg0)
        CRS5 (Arg1)
        CRS4 (Arg2)
        CRS4 (Arg3)
    }

    Method (CR_2, 2, NotSerialized)
    {
        CRS4 (0x88)
        CRS5 (0x0D)
        CRS4 (0x02)
        CRS4 (0x0C)
        CRS4 (Zero)
        CRS5 (Zero)
        CRS5 (Arg0)
        Add (Arg0, Arg1, Local0)
        Decrement (Local0)
        CRS5 (Local0)
        CRS5 (Zero)
        CRS5 (Arg1)
    }

    Method (CR_3, 2, NotSerialized)
    {
        CRS4 (0x88)
        CRS5 (0x0D)
        CRS4 (One)
        CRS4 (0x0C)
        CRS4 (0x03)
        CRS5 (Zero)
        CRS5 (Arg0)
        Add (Arg0, Arg1, Local0)
        Decrement (Local0)
        CRS5 (Local0)
        CRS5 (Zero)
        CRS5 (Arg1)
    }

    Method (CR_5, 2, NotSerialized)
    {
        CRS4 (0x8A)
        CRS5 (0x2B)
        CRS4 (Zero)
        CRS4 (0x0C)
        CRS4 (0x03)
        CRS7 (Zero)
        CRS7 (Arg0)
        Add (Arg0, Arg1, Local0)
        Decrement (Local0)
        CRS7 (Local0)
        CRS7 (Zero)
        CRS7 (Arg1)
    }

    Method (CR_4, 2, NotSerialized)
    {
        CRS4 (0x87)
        CRS5 (0x17)
        CRS4 (Zero)
        CRS4 (0x0C)
        CRS4 (0x03)
        CRS6 (Zero)
        CRS6 (Arg0)
        Add (Arg0, Arg1, Local0)
        Decrement (Local0)
        CRS6 (Local0)
        CRS6 (Zero)
        CRS6 (Arg1)
    }

    Method (CR_6, 0, NotSerialized)
    {
        CRS5 (0x79)
        Store (CRS1, Local0)
        Subtract (0x0192, 0x02, Local1)
        While (LLess (Local0, Local1))
        {
            CRS4 (Zero)
            Increment (Local0)
        }

        Store (0x79, CRS1)
    }

    Scope (_SB)
    {
        Device (PCI0)
        {
            Name (_HID, EisaId ("PNP0A03"))
            Name (_ADR, Zero)
            Name (_PRW, Package (0x02)
            {
                0x0B, 
                0x04
            })
            Method (_INI, 0, NotSerialized)
            {
                Store (SMI (0x98, Zero), MIS0)
                And (MIS0, 0x13, MIS0)
                Store (One, MIS4)
                Store (SMI (0x6D, Zero), MIS2)
                SOST ()
            }

            Method (_CRS, 0, NotSerialized)
            {
                CRS3 ()
                CR_2 (Zero, 0x0100)
                CR_3 (Zero, 0x0CF8)
                CR_1 (0x0CF8, 0x0CF8, One, 0x08)
                CR_3 (0x0D00, 0xF300)
                CR_4 (0x000A0000, 0x00020000)
                Add (0x000C0000, GORL (), Local0)
                Subtract (0x000E0000, Local0, Local1)
                CR_4 (Local0, Local1)
                Add (0x00100000, GMEM (), Local0)
                Add (Local0, 0x00100000, Local0)
                Store (GPXB (), Local3)
                Subtract (Local3, Local0, Local1)
                CR_4 (Local0, Local1)
                Add (Local3, 0x04000000, Local0)
                Subtract (0xFEC00000, Local0, Local1)
                CR_4 (Local0, Local1)
                Add (0xFEC00000, 0x00010000, Local0)
                Subtract (0xFED00000, Local0, Local1)
                CR_4 (Local0, Local1)
                Add (0xFED18000, 0x4000, Local0)
                Subtract (0xFED20000, Local0, Local1)
                CR_4 (Local0, Local1)
                Add (0xFED20000, 0x00070000, Local0)
                Subtract (0xFEDA0000, Local0, Local1)
                CR_4 (Local0, Local1)
                CR_4 (0xFED40000, 0x5000)
                Add (0xFEDA6000, 0x1000, Local0)
                Subtract (0xFEE00000, Local0, Local1)
                CR_4 (Local0, Local1)
                Add (0xFEE00000, 0x00010000, Local0)
                Subtract (0xFFA00000, Local0, Local1)
                CR_4 (Local0, Local1)
                Add (0xFFA00000, 0x00200000, Local0)
                Subtract (0xFFE00000, Local0, Local1)
                CR_4 (Local0, Local1)
                CR_6 ()
                Return (CRS0)
            }

            Device (ISAB)
            {
                Name (_ADR, 0x001F0000)
                Device (PS2M)
                {
                    Name (_HID, EisaId ("PNP0F13"))
                    Name (CRS, ResourceTemplate ()
                    {
                        IRQNoFlags ()
                            {12}
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (CRS)
                    }
                }

                Device (KBC)
                {
                    Name (_HID, EisaId ("PNP0303"))
                    Name (CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0060,             // Range Minimum
                            0x0060,             // Range Maximum
                            0x10,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0064,             // Range Minimum
                            0x0064,             // Range Maximum
                            0x04,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0062,             // Range Minimum
                            0x0062,             // Range Maximum
                            0x02,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0066,             // Range Minimum
                            0x0066,             // Range Maximum
                            0x06,               // Alignment
                            0x01,               // Length
                            )
                        IRQNoFlags ()
                            {1}
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (CRS)
                    }
                }

                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00"))
                    Name (RT, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x10,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0072,             // Range Minimum
                            0x0072,             // Range Maximum
                            0x02,               // Alignment
                            0x06,               // Length
                            )
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (RT)
                    }
                }

                Device (TMR)
                {
                    Name (_HID, EisaId ("PNP0100"))
                    Name (TM, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0040,             // Range Minimum
                            0x0040,             // Range Maximum
                            0x10,               // Alignment
                            0x04,               // Length
                            )
                        IO (Decode16,
                            0x0050,             // Range Minimum
                            0x0050,             // Range Maximum
                            0x10,               // Alignment
                            0x04,               // Length
                            )
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (TM)
                    }
                }

                Device (SPKR)
                {
                    Name (_HID, EisaId ("PNP0800"))
                    Name (CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0061,             // Range Minimum
                            0x0061,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0063,             // Range Minimum
                            0x0063,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0065,             // Range Minimum
                            0x0065,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0067,             // Range Minimum
                            0x0067,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (CRS)
                    }
                }

                Device (MB4)
                {
                    Name (_HID, EisaId ("PNP0C01"))
                    Name (_UID, 0x04)
                    Name (CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x002E,             // Range Minimum
                            0x002E,             // Range Maximum
                            0x02,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0C80,             // Range Minimum
                            0x0C80,             // Range Maximum
                            0x10,               // Alignment
                            0x30,               // Length
                            )
                        IO (Decode16,
                            0x0CC0,             // Range Minimum
                            0x0CC0,             // Range Maximum
                            0x10,               // Alignment
                            0x40,               // Length
                            )
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (CRS)
                    }
                }

                Device (PIC)
                {
                    Name (_HID, EisaId ("PNP0000"))
                    Name (CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0024,             // Range Minimum
                            0x0024,             // Range Maximum
                            0x04,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0028,             // Range Minimum
                            0x0028,             // Range Maximum
                            0x04,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x002C,             // Range Minimum
                            0x002C,             // Range Maximum
                            0x04,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0030,             // Range Minimum
                            0x0030,             // Range Maximum
                            0x04,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0034,             // Range Minimum
                            0x0034,             // Range Maximum
                            0x04,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0038,             // Range Minimum
                            0x0038,             // Range Maximum
                            0x04,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x003C,             // Range Minimum
                            0x003C,             // Range Maximum
                            0x04,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A4,             // Range Minimum
                            0x00A4,             // Range Maximum
                            0x04,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A8,             // Range Minimum
                            0x00A8,             // Range Maximum
                            0x04,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00AC,             // Range Minimum
                            0x00AC,             // Range Maximum
                            0x04,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00B0,             // Range Minimum
                            0x00B0,             // Range Maximum
                            0x04,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00B4,             // Range Minimum
                            0x00B4,             // Range Maximum
                            0x04,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00B8,             // Range Minimum
                            0x00B8,             // Range Maximum
                            0x04,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00BC,             // Range Minimum
                            0x00BC,             // Range Maximum
                            0x04,               // Alignment
                            0x02,               // Length
                            )
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (CRS)
                    }
                }

                Device (MAD)
                {
                    Name (_HID, EisaId ("PNP0200"))
                    Name (CRS, ResourceTemplate ()
                    {
                        DMA (Compatibility, BusMaster, Transfer8, )
                            {4}
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x10,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x0080,             // Range Minimum
                            0x0080,             // Range Maximum
                            0x10,               // Alignment
                            0x06,               // Length
                            )
                        IO (Decode16,
                            0x0087,             // Range Minimum
                            0x0087,             // Range Maximum
                            0x01,               // Alignment
                            0x09,               // Length
                            )
                        IO (Decode16,
                            0x00C0,             // Range Minimum
                            0x00C0,             // Range Maximum
                            0x10,               // Alignment
                            0x20,               // Length
                            )
                        IO (Decode16,
                            0x0010,             // Range Minimum
                            0x0010,             // Range Maximum
                            0x10,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x0090,             // Range Minimum
                            0x0090,             // Range Maximum
                            0x10,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0093,             // Range Minimum
                            0x0093,             // Range Maximum
                            0x01,               // Alignment
                            0x0D,               // Length
                            )
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (CRS)
                    }
                }

                Device (COPR)
                {
                    Name (_HID, EisaId ("PNP0C04"))
                    Name (CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x00F0,             // Range Minimum
                            0x00F0,             // Range Maximum
                            0x10,               // Alignment
                            0x10,               // Length
                            )
                        IRQNoFlags ()
                            {13}
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (CRS)
                    }
                }

                Device (HPET)
                {
                    Name (_HID, EisaId ("PNP0103"))
                    Name (ATT3, ResourceTemplate ()
                    {
                        IRQNoFlags ()
                            {0}
                        IRQNoFlags ()
                            {8}
                        Memory32Fixed (ReadWrite,
                            0xFED00000,         // Address Base
                            0x00000400,         // Address Length
                            )
                    })
                    Name (ATT4, ResourceTemplate ()
                    {
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (ATT3)
                    }
                }

                Device (UAR1)
                {
                    Name (_HID, EisaId ("PNP0501"))
                    Name (_UID, One)
                    Method (_EJ0, 1, NotSerialized)
                    {
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        Store (PNPQ (0x02), Local1)
                        Return (Local1)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        PNPD (0x02)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (PNPG (0x02))
                    }

                    Method (_PRS, 0, NotSerialized)
                    {
                        Name (BUF0, ResourceTemplate ()
                        {
                            StartDependentFn (0x01, 0x01)
                            {
                                IRQ (Edge, ActiveHigh, Shared, )
                                    {3,4,6,12}
                                IO (Decode16,
                                    0x03F8,             // Range Minimum
                                    0x03F8,             // Range Maximum
                                    0x08,               // Alignment
                                    0x08,               // Length
                                    )
                            }
                            StartDependentFn (0x01, 0x01)
                            {
                                IRQ (Edge, ActiveHigh, Shared, )
                                    {3,4,6,12}
                                IO (Decode16,
                                    0x02F8,             // Range Minimum
                                    0x02F8,             // Range Maximum
                                    0x08,               // Alignment
                                    0x08,               // Length
                                    )
                            }
                            StartDependentFn (0x01, 0x01)
                            {
                                IRQ (Edge, ActiveHigh, Shared, )
                                    {3,4,6,12}
                                IO (Decode16,
                                    0x03E8,             // Range Minimum
                                    0x03E8,             // Range Maximum
                                    0x08,               // Alignment
                                    0x08,               // Length
                                    )
                            }
                            StartDependentFn (0x01, 0x01)
                            {
                                IRQ (Edge, ActiveHigh, Shared, )
                                    {3,4,6,12}
                                IO (Decode16,
                                    0x02E8,             // Range Minimum
                                    0x02E8,             // Range Maximum
                                    0x08,               // Alignment
                                    0x08,               // Length
                                    )
                            }
                            EndDependentFn ()
                        })
                        Return (BUF0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        PNPS (0x02, Arg0)
                    }
                }

                Device (ECP)
                {
                    Name (_HID, EisaId ("PNP0401"))
                    Method (_EJ0, 1, NotSerialized)
                    {
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        Store (PNPQ (One), Local1)
                        Return (Local1)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        PNPD (One)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (PNPG (One))
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        StartDependentFnNoPri ()
                        {
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {}
                            IRQNoFlags ()
                                {3,4,5,7}
                            IO (Decode16,
                                0x0378,             // Range Minimum
                                0x0378,             // Range Maximum
                                0x08,               // Alignment
                                0x08,               // Length
                                )
                            IO (Decode16,
                                0x0778,             // Range Minimum
                                0x0778,             // Range Maximum
                                0x08,               // Alignment
                                0x04,               // Length
                                )
                        }
                        StartDependentFnNoPri ()
                        {
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {1,2,3}
                            IRQNoFlags ()
                                {7}
                            IO (Decode16,
                                0x0378,             // Range Minimum
                                0x0378,             // Range Maximum
                                0x08,               // Alignment
                                0x08,               // Length
                                )
                            IO (Decode16,
                                0x0778,             // Range Minimum
                                0x0778,             // Range Maximum
                                0x08,               // Alignment
                                0x04,               // Length
                                )
                        }
                        StartDependentFnNoPri ()
                        {
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {}
                            IRQNoFlags ()
                                {3,4,5,7}
                            IO (Decode16,
                                0x0278,             // Range Minimum
                                0x0278,             // Range Maximum
                                0x08,               // Alignment
                                0x08,               // Length
                                )
                            IO (Decode16,
                                0x0678,             // Range Minimum
                                0x0678,             // Range Maximum
                                0x08,               // Alignment
                                0x04,               // Length
                                )
                        }
                        StartDependentFnNoPri ()
                        {
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {1,2,3}
                            IRQNoFlags ()
                                {3,4,5,7}
                            IO (Decode16,
                                0x0278,             // Range Minimum
                                0x0278,             // Range Maximum
                                0x08,               // Alignment
                                0x08,               // Length
                                )
                            IO (Decode16,
                                0x0678,             // Range Minimum
                                0x0678,             // Range Maximum
                                0x08,               // Alignment
                                0x04,               // Length
                                )
                        }
                        StartDependentFnNoPri ()
                        {
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {}
                            IRQNoFlags ()
                                {3,4,5,7}
                            IO (Decode16,
                                0x03BC,             // Range Minimum
                                0x03BC,             // Range Maximum
                                0x04,               // Alignment
                                0x04,               // Length
                                )
                            IO (Decode16,
                                0x07BC,             // Range Minimum
                                0x07BC,             // Range Maximum
                                0x04,               // Alignment
                                0x04,               // Length
                                )
                        }
                        StartDependentFnNoPri ()
                        {
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {1,2,3}
                            IRQNoFlags ()
                                {3,4,5,7}
                            IO (Decode16,
                                0x03BC,             // Range Minimum
                                0x03BC,             // Range Maximum
                                0x04,               // Alignment
                                0x04,               // Length
                                )
                            IO (Decode16,
                                0x07BC,             // Range Minimum
                                0x07BC,             // Range Maximum
                                0x04,               // Alignment
                                0x04,               // Length
                                )
                        }
                        StartDependentFnNoPri ()
                        {
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {}
                            IRQNoFlags ()
                                {}
                            IO (Decode16,
                                0x0378,             // Range Minimum
                                0x0378,             // Range Maximum
                                0x08,               // Alignment
                                0x08,               // Length
                                )
                            IO (Decode16,
                                0x0778,             // Range Minimum
                                0x0778,             // Range Maximum
                                0x08,               // Alignment
                                0x04,               // Length
                                )
                        }
                        StartDependentFnNoPri ()
                        {
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {}
                            IRQNoFlags ()
                                {}
                            IO (Decode16,
                                0x0278,             // Range Minimum
                                0x0278,             // Range Maximum
                                0x08,               // Alignment
                                0x08,               // Length
                                )
                            IO (Decode16,
                                0x0678,             // Range Minimum
                                0x0678,             // Range Maximum
                                0x08,               // Alignment
                                0x04,               // Length
                                )
                        }
                        StartDependentFnNoPri ()
                        {
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {}
                            IRQNoFlags ()
                                {}
                            IO (Decode16,
                                0x03BC,             // Range Minimum
                                0x03BC,             // Range Maximum
                                0x04,               // Alignment
                                0x04,               // Length
                                )
                            IO (Decode16,
                                0x07BC,             // Range Minimum
                                0x07BC,             // Range Maximum
                                0x04,               // Alignment
                                0x04,               // Length
                                )
                        }
                        EndDependentFn ()
                    })
                    Method (_SRS, 1, NotSerialized)
                    {
                        PNPS (One, Arg0)
                    }
                }

                Device (TPM)
                {
                    Name (_HID, EisaId ("BCM0102"))
                    Name (_CID, EisaId ("PNP0C31"))
                    Method (_STA, 0, NotSerialized)
                    {
                        SX10 ()
                        SX30 (0x0E)
                        SX11 ()
                        Store (SX42 (), Local0)
                        SX12 ()
                        Return (Local0)
                    }

                    Name (CRS, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadWrite,
                            0xFED40000,         // Address Base
                            0x00005000,         // Address Length
                            )
                        IO (Decode16,
                            0x0CB0,             // Range Minimum
                            0x0CB0,             // Range Maximum
                            0x10,               // Alignment
                            0x0C,               // Length
                            )
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (CRS)
                    }

                    Method (_DSM, 4, NotSerialized)
                    {
                        If (LEqual (ToBuffer (Arg0), Buffer (0x10)
                                {
                                    /* 0000 */    0xA6, 0xFA, 0xDD, 0x3D, 0x1B, 0x36, 0xB4, 0x4E, 
                                    /* 0008 */    0xA4, 0x24, 0x8D, 0x10, 0x08, 0x9D, 0x16, 0x53
                                }))
                        {
                            Name (T0_0, Zero)
                            Store (ToInteger (Arg2), T0_0)
                            If (LEqual (T0_0, Zero))
                            {
                                Return (Buffer (One)
                                {
                                    0x3F
                                })
                            }
                            Else
                            {
                                If (LEqual (T0_0, One))
                                {
                                    Return ("1.0")
                                }
                                Else
                                {
                                    If (LEqual (T0_0, 0x02))
                                    {
                                        Store (ToInteger (Arg3), Local0)
                                        And (Local0, 0x0F, Local0)
                                        Store (SMI (0xCA, Local0), Local0)
                                        Return (Zero)
                                    }
                                    Else
                                    {
                                        If (LEqual (T0_0, 0x03))
                                        {
                                            Store (SMI (0xC9, 0x7E), Local0)
                                            And (Local0, 0x0F, Local0)
                                            Return (PPR2 (Local0))
                                        }
                                        Else
                                        {
                                            If (LEqual (T0_0, 0x04))
                                            {
                                                Return (0x02)
                                            }
                                            Else
                                            {
                                                If (LEqual (T0_0, 0x05))
                                                {
                                                    Store (SMI (0xC9, 0x7E), Local0)
                                                    ShiftRight (Local0, 0x04, Local0)
                                                    Store (SMI (0xC9, 0x7F), Local1)
                                                    And (Local1, 0x7F, Local1)
                                                    Return (PPR3 (Local0, Local1))
                                                }
                                                Else
                                                {
                                                    If (LEqual (T0_0, 0x06))
                                                    {
                                                        Name (T0_1, "")
                                                        Store (ToString (Arg3, Ones), T0_1)
                                                        If (LEqual (T0_1, "en"))
                                                        {
                                                            Return (Zero)
                                                        }
                                                        Else
                                                        {
                                                            Return (One)
                                                        }
                                                    }
                                                    Else
                                                    {
                                                        Return (Buffer (One)
                                                        {
                                                            0x00
                                                        })
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        If (LEqual (ToBuffer (Arg0), Buffer (0x10)
                                {
                                    /* 0000 */    0xED, 0x54, 0x60, 0x37, 0x13, 0xCC, 0x75, 0x46, 
                                    /* 0008 */    0x90, 0x1C, 0x47, 0x56, 0xD7, 0xF2, 0xD4, 0x5D
                                }))
                        {
                            Name (T0_2, Zero)
                            Store (ToInteger (Arg2), T0_2)
                            If (LEqual (T0_2, Zero))
                            {
                                Return (Buffer (One)
                                {
                                    0x01
                                })
                            }
                            Else
                            {
                                If (LEqual (T0_2, One))
                                {
                                    Store (SMI (0xCB, And (ToInteger (Arg3), One)), Local1)
                                    Return (ToInteger (Local1))
                                }
                            }
                        }

                        Return (Buffer (One)
                        {
                            0x00
                        })
                    }

                    Method (PPR2, 1, NotSerialized)
                    {
                        Name (T0_0, Zero)
                        Store (ToInteger (Arg0), T0_0)
                        If (LEqual (T0_0, Zero))
                        {
                            Return (Package (0x02)
                            {
                                Zero, 
                                Zero
                            })
                        }
                        Else
                        {
                            If (LEqual (T0_0, One))
                            {
                                Return (Package (0x02)
                                {
                                    Zero, 
                                    One
                                })
                            }
                            Else
                            {
                                If (LEqual (T0_0, 0x02))
                                {
                                    Return (Package (0x02)
                                    {
                                        Zero, 
                                        0x02
                                    })
                                }
                                Else
                                {
                                    If (LEqual (T0_0, 0x03))
                                    {
                                        Return (Package (0x02)
                                        {
                                            Zero, 
                                            0x03
                                        })
                                    }
                                    Else
                                    {
                                        If (LEqual (T0_0, 0x04))
                                        {
                                            Return (Package (0x02)
                                            {
                                                Zero, 
                                                0x04
                                            })
                                        }
                                        Else
                                        {
                                            If (LEqual (T0_0, 0x05))
                                            {
                                                Return (Package (0x02)
                                                {
                                                    Zero, 
                                                    0x05
                                                })
                                            }
                                            Else
                                            {
                                                If (LEqual (T0_0, 0x06))
                                                {
                                                    Return (Package (0x02)
                                                    {
                                                        Zero, 
                                                        0x06
                                                    })
                                                }
                                                Else
                                                {
                                                    If (LEqual (T0_0, 0x07))
                                                    {
                                                        Return (Package (0x02)
                                                        {
                                                            Zero, 
                                                            0x07
                                                        })
                                                    }
                                                    Else
                                                    {
                                                        If (LEqual (T0_0, 0x08))
                                                        {
                                                            Return (Package (0x02)
                                                            {
                                                                Zero, 
                                                                0x08
                                                            })
                                                        }
                                                        Else
                                                        {
                                                            If (LEqual (T0_0, 0x09))
                                                            {
                                                                Return (Package (0x02)
                                                                {
                                                                    Zero, 
                                                                    0x09
                                                                })
                                                            }
                                                            Else
                                                            {
                                                                If (LEqual (T0_0, 0x0A))
                                                                {
                                                                    Return (Package (0x02)
                                                                    {
                                                                        Zero, 
                                                                        0x0A
                                                                    })
                                                                }
                                                                Else
                                                                {
                                                                    If (LEqual (T0_0, 0x0B))
                                                                    {
                                                                        Return (Package (0x02)
                                                                        {
                                                                            Zero, 
                                                                            0x0B
                                                                        })
                                                                    }
                                                                    Else
                                                                    {
                                                                        If (LEqual (T0_0, 0x0C))
                                                                        {
                                                                            Return (Package (0x02)
                                                                            {
                                                                                Zero, 
                                                                                0x0C
                                                                            })
                                                                        }
                                                                        Else
                                                                        {
                                                                            If (LEqual (T0_0, 0x0D))
                                                                            {
                                                                                Return (Package (0x02)
                                                                                {
                                                                                    Zero, 
                                                                                    0x0D
                                                                                })
                                                                            }
                                                                            Else
                                                                            {
                                                                                If (LEqual (T0_0, 0x0E))
                                                                                {
                                                                                    Return (Package (0x02)
                                                                                    {
                                                                                        Zero, 
                                                                                        0x0E
                                                                                    })
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        Return (Package (0x02)
                        {
                            One, 
                            Zero
                        })
                    }

                    Method (PPR3, 2, NotSerialized)
                    {
                        If (LEqual (Arg1, Zero))
                        {
                            Name (T0_0, Zero)
                            Store (ToInteger (Arg0), T0_0)
                            If (LEqual (T0_0, Zero))
                            {
                                Return (Package (0x03)
                                {
                                    Zero, 
                                    Zero, 
                                    Zero
                                })
                            }
                            Else
                            {
                                If (LEqual (T0_0, One))
                                {
                                    Return (Package (0x03)
                                    {
                                        Zero, 
                                        One, 
                                        Zero
                                    })
                                }
                                Else
                                {
                                    If (LEqual (T0_0, 0x02))
                                    {
                                        Return (Package (0x03)
                                        {
                                            Zero, 
                                            0x02, 
                                            Zero
                                        })
                                    }
                                    Else
                                    {
                                        If (LEqual (T0_0, 0x03))
                                        {
                                            Return (Package (0x03)
                                            {
                                                Zero, 
                                                0x03, 
                                                Zero
                                            })
                                        }
                                        Else
                                        {
                                            If (LEqual (T0_0, 0x04))
                                            {
                                                Return (Package (0x03)
                                                {
                                                    Zero, 
                                                    0x04, 
                                                    Zero
                                                })
                                            }
                                            Else
                                            {
                                                If (LEqual (T0_0, 0x05))
                                                {
                                                    Return (Package (0x03)
                                                    {
                                                        Zero, 
                                                        0x05, 
                                                        Zero
                                                    })
                                                }
                                                Else
                                                {
                                                    If (LEqual (T0_0, 0x06))
                                                    {
                                                        Return (Package (0x03)
                                                        {
                                                            Zero, 
                                                            0x06, 
                                                            Zero
                                                        })
                                                    }
                                                    Else
                                                    {
                                                        If (LEqual (T0_0, 0x07))
                                                        {
                                                            Return (Package (0x03)
                                                            {
                                                                Zero, 
                                                                0x07, 
                                                                Zero
                                                            })
                                                        }
                                                        Else
                                                        {
                                                            If (LEqual (T0_0, 0x08))
                                                            {
                                                                Return (Package (0x03)
                                                                {
                                                                    Zero, 
                                                                    0x08, 
                                                                    Zero
                                                                })
                                                            }
                                                            Else
                                                            {
                                                                If (LEqual (T0_0, 0x09))
                                                                {
                                                                    Return (Package (0x03)
                                                                    {
                                                                        Zero, 
                                                                        0x09, 
                                                                        Zero
                                                                    })
                                                                }
                                                                Else
                                                                {
                                                                    If (LEqual (T0_0, 0x0A))
                                                                    {
                                                                        Return (Package (0x03)
                                                                        {
                                                                            Zero, 
                                                                            0x0A, 
                                                                            Zero
                                                                        })
                                                                    }
                                                                    Else
                                                                    {
                                                                        If (LEqual (T0_0, 0x0B))
                                                                        {
                                                                            Return (Package (0x03)
                                                                            {
                                                                                Zero, 
                                                                                0x0B, 
                                                                                Zero
                                                                            })
                                                                        }
                                                                        Else
                                                                        {
                                                                            If (LEqual (T0_0, 0x0C))
                                                                            {
                                                                                Return (Package (0x03)
                                                                                {
                                                                                    Zero, 
                                                                                    0x0C, 
                                                                                    Zero
                                                                                })
                                                                            }
                                                                            Else
                                                                            {
                                                                                If (LEqual (T0_0, 0x0D))
                                                                                {
                                                                                    Return (Package (0x03)
                                                                                    {
                                                                                        Zero, 
                                                                                        0x0D, 
                                                                                        Zero
                                                                                    })
                                                                                }
                                                                                Else
                                                                                {
                                                                                    If (LEqual (T0_0, 0x0E))
                                                                                    {
                                                                                        Return (Package (0x03)
                                                                                        {
                                                                                            Zero, 
                                                                                            0x0E, 
                                                                                            Zero
                                                                                        })
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            Return (Package (0x03)
                            {
                                One, 
                                Zero, 
                                Zero
                            })
                        }
                        Else
                        {
                            Name (T0_1, Zero)
                            Store (ToInteger (Arg0), T0_1)
                            If (LEqual (T0_1, Zero))
                            {
                                Return (Package (0x03)
                                {
                                    Zero, 
                                    Zero, 
                                    0xFFFFFFF0
                                })
                            }
                            Else
                            {
                                If (LEqual (T0_1, One))
                                {
                                    Return (Package (0x03)
                                    {
                                        Zero, 
                                        One, 
                                        0xFFFFFFF0
                                    })
                                }
                                Else
                                {
                                    If (LEqual (T0_1, 0x02))
                                    {
                                        Return (Package (0x03)
                                        {
                                            Zero, 
                                            0x02, 
                                            0xFFFFFFF0
                                        })
                                    }
                                    Else
                                    {
                                        If (LEqual (T0_1, 0x03))
                                        {
                                            Return (Package (0x03)
                                            {
                                                Zero, 
                                                0x03, 
                                                0xFFFFFFF0
                                            })
                                        }
                                        Else
                                        {
                                            If (LEqual (T0_1, 0x04))
                                            {
                                                Return (Package (0x03)
                                                {
                                                    Zero, 
                                                    0x04, 
                                                    0xFFFFFFF0
                                                })
                                            }
                                            Else
                                            {
                                                If (LEqual (T0_1, 0x05))
                                                {
                                                    Return (Package (0x03)
                                                    {
                                                        Zero, 
                                                        0x05, 
                                                        0xFFFFFFF0
                                                    })
                                                }
                                                Else
                                                {
                                                    If (LEqual (T0_1, 0x06))
                                                    {
                                                        Return (Package (0x03)
                                                        {
                                                            Zero, 
                                                            0x06, 
                                                            0xFFFFFFF0
                                                        })
                                                    }
                                                    Else
                                                    {
                                                        If (LEqual (T0_1, 0x07))
                                                        {
                                                            Return (Package (0x03)
                                                            {
                                                                Zero, 
                                                                0x07, 
                                                                0xFFFFFFF0
                                                            })
                                                        }
                                                        Else
                                                        {
                                                            If (LEqual (T0_1, 0x08))
                                                            {
                                                                Return (Package (0x03)
                                                                {
                                                                    Zero, 
                                                                    0x08, 
                                                                    0xFFFFFFF0
                                                                })
                                                            }
                                                            Else
                                                            {
                                                                If (LEqual (T0_1, 0x09))
                                                                {
                                                                    Return (Package (0x03)
                                                                    {
                                                                        Zero, 
                                                                        0x09, 
                                                                        0xFFFFFFF0
                                                                    })
                                                                }
                                                                Else
                                                                {
                                                                    If (LEqual (T0_1, 0x0A))
                                                                    {
                                                                        Return (Package (0x03)
                                                                        {
                                                                            Zero, 
                                                                            0x0A, 
                                                                            0xFFFFFFF0
                                                                        })
                                                                    }
                                                                    Else
                                                                    {
                                                                        If (LEqual (T0_1, 0x0B))
                                                                        {
                                                                            Return (Package (0x03)
                                                                            {
                                                                                Zero, 
                                                                                0x0B, 
                                                                                0xFFFFFFF0
                                                                            })
                                                                        }
                                                                        Else
                                                                        {
                                                                            If (LEqual (T0_1, 0x0C))
                                                                            {
                                                                                Return (Package (0x03)
                                                                                {
                                                                                    Zero, 
                                                                                    0x0C, 
                                                                                    0xFFFFFFF0
                                                                                })
                                                                            }
                                                                            Else
                                                                            {
                                                                                If (LEqual (T0_1, 0x0D))
                                                                                {
                                                                                    Return (Package (0x03)
                                                                                    {
                                                                                        Zero, 
                                                                                        0x0D, 
                                                                                        0xFFFFFFF0
                                                                                    })
                                                                                }
                                                                                Else
                                                                                {
                                                                                    If (LEqual (T0_1, 0x0E))
                                                                                    {
                                                                                        Return (Package (0x03)
                                                                                        {
                                                                                            Zero, 
                                                                                            0x0E, 
                                                                                            0xFFFFFFF0
                                                                                        })
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            Return (Package (0x03)
                            {
                                One, 
                                Zero, 
                                Zero
                            })
                        }
                    }
                }

                Device (FTPM)
                {
                    Name (_HID, EisaId ("PNP0C01"))
                    Name (_UID, 0x05)
                    Method (_STA, 0, NotSerialized)
                    {
                        SX10 ()
                        SX30 (0x0E)
                        SX11 ()
                        Store (SX42 (), Local0)
                        SX12 ()
                        If (Local0)
                        {
                            Return (Zero)
                        }

                        Return (0x0F)
                    }

                    Name (FCRS, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadWrite,
                            0xFED40000,         // Address Base
                            0x00005000,         // Address Length
                            )
                        IO (Decode16,
                            0x0CB0,             // Range Minimum
                            0x0CB0,             // Range Maximum
                            0x10,               // Alignment
                            0x0C,               // Length
                            )
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (FCRS)
                    }
                }
            }

            Device (PCIE)
            {
                Name (_ADR, 0x001E0000)
                Name (_PRW, Package (0x02)
                {
                    0x0B, 
                    0x04
                })
                Device (CRD0)
                {
                    Name (_ADR, 0x00010000)
                    Method (_INI, 0, NotSerialized)
                    {
                        SMI (0x95, 0x04)
                    }

                    Name (_S1D, Zero)
                    Name (_S3D, 0x03)
                }

                Device (CRD1)
                {
                    Name (_ADR, 0x00010005)
                    Method (_INI, 0, NotSerialized)
                    {
                        SMI (0x9D, 0x04)
                    }

                    Name (_S1D, Zero)
                    Name (_S3D, 0x03)
                }
            }

            Method (UCMD, 3, NotSerialized)
            {
                SX10 ()
                SX30 (0x0F)
                SX30 (Arg0)
                SX30 (Arg1)
                SX30 (Arg2)
                SX11 ()
                Store (SX40 (), Local0)
                SX12 ()
                Return (Local0)
            }

            Method (UPSW, 2, NotSerialized)
            {
                Return (UCMD (0x02, Arg0, Arg1))
            }

            Method (UPRW, 2, NotSerialized)
            {
                Return (UCMD (One, Arg0, Arg1))
            }

            Device (USB1)
            {
                Name (_ADR, 0x001D0000)
                Method (_PRW, 0, NotSerialized)
                {
                    Store (UPRW (Zero, Zero), Local0)
                    If (LEqual (Local0, 0x03))
                    {
                        Return (Package (0x02)
                        {
                            0x03, 
                            0x03
                        })
                    }

                    If (LEqual (Local0, One))
                    {
                        Return (Package (0x02)
                        {
                            0x03, 
                            One
                        })
                    }

                    Return (Package (0x02)
                    {
                        0x03, 
                        Zero
                    })
                }

                Method (_PSW, 1, NotSerialized)
                {
                    UPSW (Arg0, Zero)
                }

                Device (HUB0)
                {
                    Name (_ADR, Zero)
                    Device (CH00)
                    {
                        Name (_ADR, One)
                    }

                    Device (CH01)
                    {
                        Name (_ADR, 0x02)
                    }
                }
            }

            Device (USB2)
            {
                Name (_ADR, 0x001D0001)
                Method (_PRW, 0, NotSerialized)
                {
                    Store (UPRW (Zero, One), Local0)
                    If (LEqual (Local0, 0x03))
                    {
                        Return (Package (0x02)
                        {
                            0x04, 
                            0x03
                        })
                    }

                    If (LEqual (Local0, One))
                    {
                        Return (Package (0x02)
                        {
                            0x04, 
                            One
                        })
                    }

                    Return (Package (0x02)
                    {
                        0x04, 
                        Zero
                    })
                }

                Method (_PSW, 1, NotSerialized)
                {
                    UPSW (Arg0, One)
                }

                Device (HUB1)
                {
                    Name (_ADR, Zero)
                    Device (CH10)
                    {
                        Name (_ADR, One)
                    }

                    Device (CH11)
                    {
                        Name (_ADR, 0x02)
                    }
                }
            }

            Device (USB3)
            {
                Name (_ADR, 0x001D0002)
                Method (_PRW, 0, NotSerialized)
                {
                    Store (UPRW (Zero, 0x02), Local0)
                    If (LEqual (Local0, 0x03))
                    {
                        Return (Package (0x02)
                        {
                            0x0C, 
                            0x03
                        })
                    }

                    If (LEqual (Local0, One))
                    {
                        Return (Package (0x02)
                        {
                            0x0C, 
                            One
                        })
                    }

                    Return (Package (0x02)
                    {
                        0x0C, 
                        Zero
                    })
                }

                Method (_PSW, 1, NotSerialized)
                {
                    UPSW (Arg0, 0x02)
                }

                Device (HUB2)
                {
                    Name (_ADR, Zero)
                    Device (CH20)
                    {
                        Name (_ADR, One)
                        Name (_UPC, Package (0x04)
                        {
                            0xFF, 
                            0xFF, 
                            Zero, 
                            Zero
                        })
                        Name (_PLD, Buffer (0x10)
                        {
                            /* 0000 */    0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                            /* 0008 */    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                        })
                    }

                    Device (CH21)
                    {
                        Name (_ADR, 0x02)
                        Name (_UPC, Package (0x04)
                        {
                            0xFF, 
                            0xFF, 
                            Zero, 
                            Zero
                        })
                        Name (_PLD, Buffer (0x10)
                        {
                            /* 0000 */    0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                            /* 0008 */    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                        })
                    }
                }
            }

            Device (USB4)
            {
                Name (_ADR, 0x001A0000)
                Method (_PRW, 0, NotSerialized)
                {
                    Store (UPRW (Zero, 0x03), Local0)
                    If (LEqual (Local0, 0x03))
                    {
                        Return (Package (0x02)
                        {
                            0x0E, 
                            0x03
                        })
                    }

                    If (LEqual (Local0, One))
                    {
                        Return (Package (0x02)
                        {
                            0x0E, 
                            One
                        })
                    }

                    Return (Package (0x02)
                    {
                        0x0E, 
                        Zero
                    })
                }

                Method (_PSW, 1, NotSerialized)
                {
                    UPSW (Arg0, 0x03)
                }

                Device (HUB3)
                {
                    Name (_ADR, Zero)
                    Device (CH30)
                    {
                        Name (_ADR, One)
                        Name (_UPC, Package (0x04)
                        {
                            0xFF, 
                            0xFF, 
                            Zero, 
                            Zero
                        })
                        Name (_PLD, Buffer (0x10)
                        {
                            /* 0000 */    0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                            /* 0008 */    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                        })
                    }

                    Device (CH31)
                    {
                        Name (_ADR, 0x02)
                    }
                }
            }

            Device (USB5)
            {
                Name (_ADR, 0x001A0001)
                Method (_PRW, 0, NotSerialized)
                {
                    Store (UPRW (Zero, 0x04), Local0)
                    If (LEqual (Local0, 0x03))
                    {
                        Return (Package (0x02)
                        {
                            0x05, 
                            0x03
                        })
                    }

                    If (LEqual (Local0, One))
                    {
                        Return (Package (0x02)
                        {
                            0x05, 
                            One
                        })
                    }

                    Return (Package (0x02)
                    {
                        0x05, 
                        Zero
                    })
                }

                Method (_PSW, 1, NotSerialized)
                {
                    UPSW (Arg0, 0x04)
                }

                Device (HUB4)
                {
                    Name (_ADR, Zero)
                    Device (CH40)
                    {
                        Name (_ADR, One)
                    }

                    Device (CH41)
                    {
                        Name (_ADR, 0x02)
                    }
                }
            }

            Device (USB6)
            {
                Name (_ADR, 0x001A0002)
                Method (_PRW, 0, NotSerialized)
                {
                    Store (UPRW (Zero, 0x04), Local0)
                    If (LEqual (Local0, 0x03))
                    {
                        Return (Package (0x02)
                        {
                            0x05, 
                            0x03
                        })
                    }

                    If (LEqual (Local0, One))
                    {
                        Return (Package (0x02)
                        {
                            0x05, 
                            One
                        })
                    }

                    Return (Package (0x02)
                    {
                        0x05, 
                        Zero
                    })
                }

                Method (_PSW, 1, NotSerialized)
                {
                    UPSW (Arg0, 0x04)
                }

                Device (HUB5)
                {
                    Name (_ADR, Zero)
                    Device (CH50)
                    {
                        Name (_ADR, One)
                        Name (_UPC, Package (0x04)
                        {
                            0xFF, 
                            0xFF, 
                            Zero, 
                            Zero
                        })
                        Name (_PLD, Buffer (0x10)
                        {
                            /* 0000 */    0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                            /* 0008 */    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                        })
                    }

                    Device (CH51)
                    {
                        Name (_ADR, 0x02)
                        Name (_UPC, Package (0x04)
                        {
                            0xFF, 
                            0xFF, 
                            Zero, 
                            Zero
                        })
                        Name (_PLD, Buffer (0x10)
                        {
                            /* 0000 */    0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                            /* 0008 */    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                        })
                    }
                }
            }

            Device (EHC2)
            {
                Name (_ADR, 0x001A0007)
                Name (_S1D, 0x02)
                Name (_S3D, 0x02)
                Method (_PRW, 0, NotSerialized)
                {
                    Store (UPRW (Zero, 0x07), Local0)
                    If (LEqual (Local0, 0x03))
                    {
                        Return (Package (0x02)
                        {
                            0x0D, 
                            0x03
                        })
                    }

                    If (LEqual (Local0, One))
                    {
                        Return (Package (0x02)
                        {
                            0x0D, 
                            One
                        })
                    }

                    Return (Package (0x02)
                    {
                        0x0D, 
                        Zero
                    })
                }

                Method (_PSW, 1, NotSerialized)
                {
                    UPSW (Arg0, 0x07)
                }

                Device (HUB7)
                {
                    Name (_ADR, Zero)
                    Device (CH00)
                    {
                        Name (_ADR, One)
                        Name (_UPC, Package (0x04)
                        {
                            0xFF, 
                            0xFF, 
                            Zero, 
                            Zero
                        })
                        Name (_PLD, Buffer (0x10)
                        {
                            /* 0000 */    0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                            /* 0008 */    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                        })
                    }

                    Device (CH01)
                    {
                        Name (_ADR, 0x02)
                    }

                    Device (CH10)
                    {
                        Name (_ADR, 0x03)
                    }

                    Device (CH11)
                    {
                        Name (_ADR, 0x04)
                    }

                    Device (CH20)
                    {
                        Name (_ADR, 0x05)
                        Name (_UPC, Package (0x04)
                        {
                            0xFF, 
                            0xFF, 
                            Zero, 
                            Zero
                        })
                        Name (_PLD, Buffer (0x10)
                        {
                            /* 0000 */    0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                            /* 0008 */    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                        })
                    }

                    Device (CH21)
                    {
                        Name (_ADR, 0x06)
                        Name (_UPC, Package (0x04)
                        {
                            0xFF, 
                            0xFF, 
                            Zero, 
                            Zero
                        })
                        Name (_PLD, Buffer (0x10)
                        {
                            /* 0000 */    0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                            /* 0008 */    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                        })
                    }
                }
            }

            Device (EHCI)
            {
                Name (_ADR, 0x001D0007)
                Name (_S1D, 0x02)
                Name (_S3D, 0x02)
                Method (_PRW, 0, NotSerialized)
                {
                    Store (UPRW (Zero, 0x07), Local0)
                    If (LEqual (Local0, 0x03))
                    {
                        Return (Package (0x02)
                        {
                            0x0D, 
                            0x03
                        })
                    }

                    If (LEqual (Local0, One))
                    {
                        Return (Package (0x02)
                        {
                            0x0D, 
                            One
                        })
                    }

                    Return (Package (0x02)
                    {
                        0x0D, 
                        Zero
                    })
                }

                Method (_PSW, 1, NotSerialized)
                {
                    UPSW (Arg0, 0x07)
                }

                Device (HUB7)
                {
                    Name (_ADR, Zero)
                    Device (CH00)
                    {
                        Name (_ADR, One)
                    }

                    Device (CH01)
                    {
                        Name (_ADR, 0x02)
                    }

                    Device (CH10)
                    {
                        Name (_ADR, 0x03)
                    }

                    Device (CH11)
                    {
                        Name (_ADR, 0x04)
                    }

                    Device (CH20)
                    {
                        Name (_ADR, 0x05)
                        Name (_UPC, Package (0x04)
                        {
                            0xFF, 
                            0xFF, 
                            Zero, 
                            Zero
                        })
                        Name (_PLD, Buffer (0x10)
                        {
                            /* 0000 */    0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                            /* 0008 */    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                        })
                    }

                    Device (CH21)
                    {
                        Name (_ADR, 0x06)
                        Name (_UPC, Package (0x04)
                        {
                            0xFF, 
                            0xFF, 
                            Zero, 
                            Zero
                        })
                        Name (_PLD, Buffer (0x10)
                        {
                            /* 0000 */    0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                            /* 0008 */    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                        })
                    }
                }
            }

            Device (IDE0)
            {
                Name (_ADR, 0x001F0002)
                OperationRegion (IDET, PCI_Config, 0x40, 0x04)
                Field (IDET, WordAcc, NoLock, Preserve)
                {
                    M1,     8, 
                    M2,     8, 
                    M3,     8, 
                    M4,     8
                }

                Method (_DSM, 4, NotSerialized)
                {
                    Store (0x07, M1)
                    Store (0xE3, M2)
                    Store (Zero, M3)
                    Store (0xC0, M4)
                    Return (Zero)
                }

                Method (_STA, 0, NotSerialized)
                {
                    Return (0x0F)
                }

                Device (PRI)
                {
                    Name (_ADR, Zero)
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }
                }

                Device (SEC0)
                {
                    Name (_ADR, One)
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Device (MAST)
                    {
                        Name (_ADR, Zero)
                        Name (_RMV, Zero)
                        Method (_EJ0, 1, NotSerialized)
                        {
                            SMI (0x90, 0x08)
                            Return (Zero)
                        }

                        Method (_STA, 0, NotSerialized)
                        {
                            Store (SMI (0x86, Zero), Local0)
                            If (Local0)
                            {
                                Return (0x0F)
                            }

                            Return (Zero)
                        }
                    }
                }
            }

            Device (IDE1)
            {
                Name (_ADR, 0x001F0005)
                OperationRegion (IDET, PCI_Config, 0x40, 0x04)
                Field (IDET, WordAcc, NoLock, Preserve)
                {
                    M1,     8, 
                    M2,     8, 
                    M3,     8, 
                    M4,     8
                }

                Method (_DSM, 4, NotSerialized)
                {
                    Store (0x07, M1)
                    Store (0xE3, M2)
                    Store (Zero, M3)
                    Store (0xC0, M4)
                    Return (Zero)
                }

                Method (_STA, 0, NotSerialized)
                {
                    Return (0x0F)
                }

                Device (PRI)
                {
                    Name (_ADR, Zero)
                    Device (MAST)
                    {
                        Name (_ADR, Zero)
                        Name (_RMV, Zero)
                        Method (_EJ0, 1, NotSerialized)
                        {
                            SMI (0x90, 0x08)
                            Return (Zero)
                        }

                        Method (_STA, 0, NotSerialized)
                        {
                            Store (SMI (0x86, Zero), Local0)
                            If (Local0)
                            {
                                Return (0x0F)
                            }

                            Return (Zero)
                        }
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }
                }

                Device (SEC0)
                {
                    Name (_ADR, One)
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }
                }
            }

            Device (AZAL)
            {
                Name (_ADR, 0x001B0000)
                Name (_PRW, Package (0x02)
                {
                    0x0D, 
                    0x03
                })
            }

            Device (AGP)
            {
                Name (_ADR, 0x00010000)
                Device (VID)
                {
                    Name (_ADR, Zero)
                    Name (_SUN, One)
                    Method (_DSM, 4, NotSerialized)
                    {
                        Store (Package (0x1A)
                            {
                                "@0,built-in", 
                                Buffer (One)
                                {
                                    0x01
                                }, 

                                "@0,compatible", 
                                Buffer (0x0B)
                                {
                                    "NVDA,NVMac"
                                }, 

                                "@0,device_type", 
                                Buffer (0x08)
                                {
                                    "display"
                                }, 

                                "@0,name", 
                                Buffer (0x0F)
                                {
                                    "NVDA,Display-A"
                                }, 

                                "@1,compatible", 
                                Buffer (0x0B)
                                {
                                    "NVDA,NVMac"
                                }, 

                                "@1,device_type", 
                                Buffer (0x08)
                                {
                                    "display"
                                }, 

                                "@0,display-cfg", 
                                Buffer (0x04)
                                {
                                    0x03, 0x01, 0x00, 0x00
                                }, 

                                "@1,display-cfg", 
                                Buffer (0x04)
                                {
                                    0xFF, 0xFF, 0x00, 0x01
                                }, 

                                "@1,name", 
                                Buffer (0x0F)
                                {
                                    "NVDA,Display-B"
                                }, 

                                "NVCAP", 
                                Buffer (0x18)
                                {
                                    /* 0000 */    0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 
                                    /* 0008 */    0x1E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0A, 
                                    /* 0010 */    0x00, 0x00, 0x00, 0x00
                                }, 

                                "reg", 
                                Buffer (0x78)
                                {
                                    /* 0000 */    0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 
                                    /* 0008 */    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                                    /* 0010 */    0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x01, 0x02, 
                                    /* 0018 */    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                                    /* 0020 */    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 
                                    /* 0028 */    0x14, 0x00, 0x01, 0x42, 0x00, 0x00, 0x00, 0x00, 
                                    /* 0030 */    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                                    /* 0038 */    0x00, 0x00, 0x00, 0x10, 0x1C, 0x00, 0x01, 0x02, 
                                    /* 0040 */    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                                    /* 0048 */    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 
                                    /* 0050 */    0x24, 0x00, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 
                                    /* 0058 */    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                                    /* 0060 */    0x80, 0x00, 0x00, 0x00, 0x30, 0x00, 0x01, 0x02, 
                                    /* 0068 */    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                                    /* 0070 */    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00
                                }, 

                                "device_type", 
                                Buffer (0x0C)
                                {
                                    "NVDA,Quadro"
                                }, 

                                "model", 
                                Buffer (0x16)
                                {
                                    "NVIDIA Quadro FX1700M"
                                }
                            }, Local0)
                        DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                        Return (Local0)
                    }

                    Method (_DOS, 1, NotSerialized)
                    {
                        Store (Arg0, MIS4)
                        SMI (0x9E, MIS4)
                    }

                    Method (_DOD, 0, NotSerialized)
                    {
                        If (LEqual (MIS2, One))
                        {
                            Return (Package (0x03)
                            {
                                0x00010100, 
                                0x00010110, 
                                0x00010210
                            })
                        }
                        Else
                        {
                            Return (Package (0x06)
                            {
                                0x0100, 
                                0x0110, 
                                0x0111, 
                                0x0112, 
                                0x0113, 
                                0x0114
                            })
                        }
                    }

                    Device (CRT)
                    {
                        Method (_ADR, 0, NotSerialized)
                        {
                            If (LEqual (MIS2, One))
                            {
                                Return (0x0100)
                            }
                            Else
                            {
                                Return (0x0100)
                            }
                        }

                        Method (_DCS, 0, NotSerialized)
                        {
                            Store (SMI (0x8E, 0x02), Local0)
                            Return (Local0)
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Store (SMI (0x99, 0x02), Local0)
                            Return (Local0)
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                            DSS (0x02, Arg0)
                        }
                    }

                    Device (LCD)
                    {
                        Method (_ADR, 0, NotSerialized)
                        {
                            If (LEqual (MIS2, One))
                            {
                                Return (0x0110)
                            }
                            Else
                            {
                                Return (0x0110)
                            }
                        }

                        Method (_DCS, 0, NotSerialized)
                        {
                            Store (SMI (0x8E, One), Local0)
                            Return (Local0)
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Store (SMI (0x99, One), Local0)
                            Return (Local0)
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                            DSS (One, Arg0)
                        }

                        Name (BTVL, 0x64)
                        Name (DBCL, Package (0x12) {})
                        Method (_BCL, 0, NotSerialized)
                        {
                            SX10 ()
                            SX30 (0x19)
                            SX30 (Zero)
                            SX11 ()
                            Store (Zero, Local0)
                            Add (0x02, 0x10, Local1)
                            While (LLess (Local0, Local1))
                            {
                                Store (SX40 (), Index (DBCL, Local0))
                                Increment (Local0)
                            }

                            SX12 ()
                            Return (DBCL)
                        }

                        Method (_BCM, 1, NotSerialized)
                        {
                            SX10 ()
                            SX30 (0x19)
                            SX30 (One)
                            SX30 (Arg0)
                            Store (Arg0, BTVL)
                            SX11 ()
                            SX12 ()
                        }

                        Method (_BQC, 0, NotSerialized)
                        {
                            SX10 ()
                            SX30 (0x19)
                            SX30 (0x02)
                            SX11 ()
                            Store (SX40 (), Local0)
                            Store (Local0, BTVL)
                            SX12 ()
                            Return (Local0)
                        }
                    }

                    Device (DVI)
                    {
                        Method (_ADR, 0, NotSerialized)
                        {
                            If (LEqual (MIS2, One))
                            {
                                Return (0x0210)
                            }
                            Else
                            {
                                Return (0x0112)
                            }
                        }

                        Method (_DCS, 0, NotSerialized)
                        {
                            Store (SMI (0x8E, 0x08), Local0)
                            Return (Local0)
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Store (SMI (0x99, 0x08), Local0)
                            Return (Local0)
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                            DSS (0x08, Arg0)
                        }
                    }

                    Device (DVI2)
                    {
                        Method (_ADR, 0, NotSerialized)
                        {
                            Return (0x0111)
                        }

                        Method (_DCS, 0, NotSerialized)
                        {
                            Store (SMI (0x8E, 0x10), Local0)
                            Return (Local0)
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Store (SMI (0x99, 0x10), Local0)
                            Return (Local0)
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                            DSS (0x10, Arg0)
                        }
                    }

                    Device (DP)
                    {
                        Method (_ADR, 0, NotSerialized)
                        {
                            Return (0x0113)
                        }

                        Method (_DCS, 0, NotSerialized)
                        {
                            Store (SMI (0x8E, 0x20), Local0)
                            Return (Local0)
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Store (SMI (0x99, 0x20), Local0)
                            Return (Local0)
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                            DSS (0x20, Arg0)
                        }
                    }

                    Device (DP2)
                    {
                        Method (_ADR, 0, NotSerialized)
                        {
                            Return (0x0114)
                        }

                        Method (_DCS, 0, NotSerialized)
                        {
                            Store (SMI (0x8E, 0x40), Local0)
                            Return (Local0)
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Store (SMI (0x99, 0x40), Local0)
                            Return (Local0)
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                            DSS (0x40, Arg0)
                        }
                    }
                }
            }

            Scope (\_SB)
            {
                Device (MB1)
                {
                    Name (_HID, EisaId ("PNP0C01"))
                    Name (_UID, One)
                    Method (_CRS, 0, NotSerialized)
                    {
                        CRS3 ()
                        CR_0 (One, Zero, 0x0009F000)
                        CR_0 (One, 0x0009F000, 0x1000)
                        If (LGreaterEqual (OSID (), 0x08))
                        {
                            Store (GORL (), Local0)
                            CR_0 (Zero, 0x000C0000, Local0)
                        }

                        CR_0 (Zero, 0x000E0000, 0x00020000)
                        Store (GMEM (), Local0)
                        Subtract (Local0, 0x00AAE400, Local1)
                        CR_0 (One, 0x00100000, Local1)
                        Add (Local1, 0x00100000, Local1)
                        CR_0 (One, Local1, 0x00AAE400)
                        Store (SMMB (), Local0)
                        CR_0 (One, Local0, 0x00100000)
                        CR_0 (Zero, 0xFFE00000, 0x00200000)
                        CR_0 (Zero, 0xFFA00000, 0x00200000)
                        CR_0 (One, 0xFEC00000, 0x00010000)
                        CR_0 (One, 0xFEE00000, 0x00010000)
                        CR_0 (Zero, 0xFED20000, 0x00020000)
                        CR_0 (Zero, 0xFED45000, 0x0004B000)
                        CR_0 (One, 0xFEDA0000, 0x4000)
                        CR_0 (One, 0xFEDA4000, 0x1000)
                        CR_0 (One, 0xFEDA5000, 0x1000)
                        CR_0 (One, 0xFEDA6000, 0x1000)
                        CR_0 (One, 0xFED1C800, 0x0800)
                        CR_0 (One, 0xFED18000, 0x4000)
                        Store (GPXB (), Local0)
                        CR_0 (One, Local0, 0x04000000)
                        CR_6 ()
                        Return (CRS0)
                    }
                }
            }

            Scope (\_SB.PCI0)
            {
                Device (MB2)
                {
                    Name (_HID, EisaId ("PNP0C01"))
                    Name (_UID, 0x02)
                    Name (CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0900,             // Range Minimum
                            0x0900,             // Range Maximum
                            0x01,               // Alignment
                            0x30,               // Length
                            )
                        IO (Decode16,
                            0x0931,             // Range Minimum
                            0x0931,             // Range Maximum
                            0x01,               // Alignment
                            0x03,               // Length
                            )
                        IO (Decode16,
                            0x0935,             // Range Minimum
                            0x0935,             // Range Maximum
                            0x01,               // Alignment
                            0x4B,               // Length
                            )
                        IO (Decode16,
                            0x0092,             // Range Minimum
                            0x0092,             // Range Maximum
                            0x02,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x00B2,             // Range Minimum
                            0x00B2,             // Range Maximum
                            0x02,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0020,             // Range Minimum
                            0x0020,             // Range Maximum
                            0x10,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A0,             // Range Minimum
                            0x00A0,             // Range Maximum
                            0x10,               // Alignment
                            0x02,               // Length
                            )
                        IRQNoFlags ()
                            {0}
                        IO (Decode16,
                            0x04D0,             // Range Minimum
                            0x04D0,             // Range Maximum
                            0x10,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x1000,             // Range Minimum
                            0x1000,             // Range Maximum
                            0x10,               // Alignment
                            0x06,               // Length
                            )
                        IO (Decode16,
                            0x1008,             // Range Minimum
                            0x1008,             // Range Maximum
                            0x08,               // Alignment
                            0x08,               // Length
                            )
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (CRS)
                    }
                }

                Device (MB3)
                {
                    Name (_HID, EisaId ("PNP0C01"))
                    Name (_UID, 0x03)
                    Name (CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0xF400,             // Range Minimum
                            0xF400,             // Range Maximum
                            0x01,               // Alignment
                            0xFF,               // Length
                            )
                        IO (Decode16,
                            0x0086,             // Range Minimum
                            0x0086,             // Range Maximum
                            0x02,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x1006,             // Range Minimum
                            0x1006,             // Range Maximum
                            0x02,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x100A,             // Range Minimum
                            0x100A,             // Range Maximum
                            0x01,               // Alignment
                            0x50,               // Length
                            )
                        IO (Decode16,
                            0x1080,             // Range Minimum
                            0x1080,             // Range Maximum
                            0x10,               // Alignment
                            0x40,               // Length
                            )
                        IO (Decode16,
                            0x1100,             // Range Minimum
                            0x1100,             // Range Maximum
                            0x10,               // Alignment
                            0x20,               // Length
                            )
                        IO (Decode16,
                            0x1010,             // Range Minimum
                            0x1010,             // Range Maximum
                            0x10,               // Alignment
                            0x20,               // Length
                            )
                        IO (Decode16,
                            0x0809,             // Range Minimum
                            0x0809,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (CRS)
                    }
                }
            }

            Scope (\_SB)
            {
            }

            Device (RP01)
            {
                Name (_ADR, 0x001C0000)
                OperationRegion (P1CS, PCI_Config, Zero, 0x0100)
                Field (P1CS, AnyAcc, NoLock, WriteAsZeros)
                {
                            Offset (0x3E), 
                        ,   6, 
                    SBSR,   1, 
                            Offset (0x52), 
                        ,   13, 
                    LSTS,   1, 
                            Offset (0x5A), 
                    ABP1,   1, 
                        ,   2, 
                    PDC1,   1, 
                        ,   2, 
                    PDS1,   1, 
                            Offset (0x5B), 
                    LASC,   1, 
                            Offset (0x60), 
                            Offset (0x62), 
                    PSP1,   1, 
                            Offset (0xDC), 
                        ,   30, 
                    HPCS,   1, 
                    PMCS,   1, 
                            Offset (0xE2), 
                            Offset (0xE3), 
                    WXME,   2
                }

                Device (PXS1)
                {
                    Name (_ADR, Zero)
                }

                Name (_PRW, Package (0x02)
                {
                    0x09, 
                    0x04
                })
                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                Zero, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                Zero, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                Zero, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                Zero, 
                                0x13
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                LNKA, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                LNKB, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                LNKC, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                LNKD, 
                                Zero
                            }
                        })
                    }
                }
            }

            Device (RP02)
            {
                Name (_ADR, 0x001C0001)
                OperationRegion (P2CS, PCI_Config, Zero, 0x0100)
                Field (P2CS, AnyAcc, NoLock, WriteAsZeros)
                {
                            Offset (0x3E), 
                        ,   6, 
                    SBSR,   1, 
                            Offset (0x52), 
                        ,   13, 
                    LSTS,   1, 
                            Offset (0x5A), 
                    ABP2,   1, 
                        ,   2, 
                    PDC2,   1, 
                        ,   2, 
                    PDS2,   1, 
                            Offset (0x5B), 
                    LASC,   1, 
                            Offset (0x60), 
                            Offset (0x62), 
                    PSP2,   1, 
                            Offset (0xDC), 
                        ,   30, 
                    HPCS,   1, 
                    PMCS,   1, 
                            Offset (0xE2), 
                            Offset (0xE3), 
                    WXME,   2
                }

                Device (PXS2)
                {
                    Name (_ADR, Zero)
                }

                Name (_PRW, Package (0x02)
                {
                    0x09, 
                    0x04
                })
                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                Zero, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                Zero, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                Zero, 
                                0x13
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                Zero, 
                                0x10
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                LNKB, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                LNKC, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                LNKD, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                LNKA, 
                                Zero
                            }
                        })
                    }
                }
            }

            Device (RP03)
            {
                Name (_ADR, 0x001C0002)
                OperationRegion (P3CS, PCI_Config, Zero, 0x0100)
                Field (P3CS, AnyAcc, NoLock, WriteAsZeros)
                {
                            Offset (0x3E), 
                        ,   6, 
                    SBSR,   1, 
                            Offset (0x52), 
                        ,   13, 
                    LSTS,   1, 
                            Offset (0x5A), 
                    ABP3,   1, 
                        ,   2, 
                    PDC3,   1, 
                        ,   2, 
                    PDS3,   1, 
                            Offset (0x5B), 
                    LASC,   1, 
                            Offset (0x60), 
                            Offset (0x62), 
                    PSP3,   1, 
                            Offset (0xDC), 
                        ,   30, 
                    HPCS,   1, 
                    PMCS,   1, 
                            Offset (0xE2), 
                            Offset (0xE3), 
                    WXME,   2
                }

                Device (PXS3)
                {
                    Name (_ADR, Zero)
                }

                Name (_PRW, Package (0x02)
                {
                    0x09, 
                    0x04
                })
                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                Zero, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                Zero, 
                                0x13
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                Zero, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                Zero, 
                                0x11
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                LNKC, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                LNKD, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                LNKA, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                LNKB, 
                                Zero
                            }
                        })
                    }
                }
            }

            Device (RP04)
            {
                Name (_ADR, 0x001C0003)
                OperationRegion (P4CS, PCI_Config, Zero, 0x0100)
                Field (P4CS, AnyAcc, NoLock, WriteAsZeros)
                {
                            Offset (0x3E), 
                        ,   6, 
                    SBSR,   1, 
                            Offset (0x52), 
                        ,   13, 
                    LSTS,   1, 
                            Offset (0x5A), 
                    ABP4,   1, 
                        ,   2, 
                    PDC4,   1, 
                        ,   2, 
                    PDS4,   1, 
                            Offset (0x5B), 
                    LASC,   1, 
                            Offset (0x60), 
                            Offset (0x62), 
                    PSP4,   1, 
                            Offset (0xDC), 
                        ,   30, 
                    HPCS,   1, 
                    PMCS,   1, 
                            Offset (0xE2), 
                            Offset (0xE3), 
                    WXME,   2
                }

                Device (PXS4)
                {
                    Name (_ADR, Zero)
                }

                Name (_PRW, Package (0x02)
                {
                    0x09, 
                    0x03
                })
                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                Zero, 
                                0x13
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                Zero, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                Zero, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                Zero, 
                                0x12
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                LNKD, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                LNKA, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                LNKB, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                LNKC, 
                                Zero
                            }
                        })
                    }
                }
            }

            Device (RP05)
            {
                Name (_ADR, 0x001C0004)
                OperationRegion (P5CS, PCI_Config, Zero, 0x0100)
                Field (P5CS, AnyAcc, NoLock, WriteAsZeros)
                {
                            Offset (0x3E), 
                        ,   6, 
                    SBSR,   1, 
                            Offset (0x52), 
                        ,   13, 
                    LSTS,   1, 
                            Offset (0x5A), 
                    ABP5,   1, 
                        ,   2, 
                    PDC5,   1, 
                        ,   2, 
                    PDS5,   1, 
                            Offset (0x5B), 
                    LASC,   1, 
                            Offset (0x60), 
                            Offset (0x62), 
                    PSP5,   1, 
                            Offset (0xDC), 
                        ,   30, 
                    HPCS,   1, 
                    PMCS,   1, 
                            Offset (0xE2), 
                            Offset (0xE3), 
                    WXME,   2
                }

                Device (PXS5)
                {
                    Name (_ADR, Zero)
                }

                Name (_PRW, Package (0x02)
                {
                    0x09, 
                    0x03
                })
                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                Zero, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                Zero, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                Zero, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                Zero, 
                                0x13
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                LNKA, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                LNKB, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                LNKC, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                LNKD, 
                                Zero
                            }
                        })
                    }
                }
            }

            Device (RP06)
            {
                Name (_ADR, 0x001C0005)
                OperationRegion (P6CS, PCI_Config, Zero, 0x0100)
                Field (P6CS, AnyAcc, NoLock, WriteAsZeros)
                {
                            Offset (0x3E), 
                        ,   6, 
                    SBSR,   1, 
                            Offset (0x52), 
                        ,   13, 
                    LSTS,   1, 
                            Offset (0x5A), 
                    ABP6,   1, 
                        ,   2, 
                    PDC6,   1, 
                        ,   2, 
                    PDS6,   1, 
                            Offset (0x5B), 
                    LASC,   1, 
                            Offset (0x60), 
                            Offset (0x62), 
                    PSP6,   1, 
                            Offset (0xDC), 
                        ,   30, 
                    HPCS,   1, 
                    PMCS,   1, 
                            Offset (0xE2), 
                            Offset (0xE3), 
                    WXME,   2
                }

                Device (PXS6)
                {
                    Name (_ADR, Zero)
                }

                Name (_PRW, Package (0x02)
                {
                    0x09, 
                    0x05
                })
                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                Zero, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                Zero, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                Zero, 
                                0x13
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                Zero, 
                                0x10
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                LNKB, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                LNKC, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                LNKD, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                LNKA, 
                                Zero
                            }
                        })
                    }
                }
            }

            Method (WKHP, 0, NotSerialized)
            {
                Notify (RP04, Zero)
            }

            Method (POHP, 0, NotSerialized)
            {
                If (Ones)
                {
                    Sleep (0x64)
                    If (^RP02.HPCS)
                    {
                        If (LAnd (LEqual (RPD2, Zero), ^RP02.PDC2))
                        {
                            While (^RP02.SBSR)
                            {
                                Sleep (0x0A)
                            }

                            Sleep (0x0A)
                            SX10 ()
                            SX30 (0x14)
                            SX11 ()
                            SX12 ()
                            Store (One, ^RP02.PDC2)
                            Store (One, ^RP02.HPCS)
                            Sleep (0x0A)
                            If (^RP02.PDS2)
                            {
                                Notify (RP02, Zero)
                            }
                        }
                        Else
                        {
                            Store (One, ^RP02.HPCS)
                        }
                    }
                }
                Else
                {
                    Sleep (0x01F4)
                    If (^RP02.HPCS)
                    {
                        If (LAnd (LEqual (RPD2, Zero), ^RP02.PDC2))
                        {
                            Store (One, ^RP02.PDC2)
                            Store (One, ^RP02.HPCS)
                            Notify (RP02, Zero)
                        }
                        Else
                        {
                            Store (One, ^RP02.HPCS)
                        }
                    }
                }

                If (Zero)
                {
                    Sleep (0x64)
                    If (^RP04.HPCS)
                    {
                        If (LAnd (LEqual (RPD4, Zero), ^RP04.PDC4))
                        {
                            While (^RP04.SBSR)
                            {
                                Sleep (0x0A)
                            }

                            Sleep (0x0A)
                            SX10 ()
                            SX30 (0x14)
                            SX11 ()
                            SX12 ()
                            Store (One, ^RP04.PDC4)
                            Store (One, ^RP04.HPCS)
                            Sleep (0x0A)
                            If (^RP04.PDS4)
                            {
                                Notify (RP04, Zero)
                            }
                        }
                        Else
                        {
                            Store (One, ^RP04.HPCS)
                        }
                    }
                }
                Else
                {
                    Sleep (0x01F4)
                    If (^RP04.HPCS)
                    {
                        If (LAnd (LEqual (RPD4, Zero), ^RP04.PDC4))
                        {
                            Store (One, ^RP04.PDC4)
                            Store (One, ^RP04.HPCS)
                            Notify (RP04, Zero)
                        }
                        Else
                        {
                            Store (One, ^RP04.HPCS)
                        }
                    }
                }
            }

            Scope (RP04.PXS4)
            {
                Name (_EJD, "\\_SB.PCI0.EHC2.HUB7.CH01")
                Method (_RMV, 0, NotSerialized)
                {
                    Return (One)
                }
            }

            Scope (EHC2.HUB7.CH01)
            {
                Name (_EJD, "\\_SB.PCI0.RP04.PXS4")
            }

            Scope (USB4.HUB3.CH31)
            {
                Name (_EJD, "\\_SB.PCI0.RP04.PXS4")
            }

            Scope (\)
            {
                Name (GPIC, Zero)
                Method (_PIC, 1, NotSerialized)
                {
                    Store (Arg0, GPIC)
                }
            }

            Scope (\_SB.PCI0)
            {
                Scope (ISAB)
                {
                    OperationRegion (PIR1, PCI_Config, 0x60, 0x04)
                    OperationRegion (PIR2, PCI_Config, 0x68, 0x04)
                    OperationRegion (FDIS, PCI_Config, 0xF2, 0x02)
                }

                Name (PIC0, Package (0x1C)
                {
                    Package (0x04)
                    {
                        0x001FFFFF, 
                        One, 
                        LNKD, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x001FFFFF, 
                        Zero, 
                        LNKC, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x001FFFFF, 
                        One, 
                        LNKB, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x001FFFFF, 
                        0x02, 
                        LNKC, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x001FFFFF, 
                        0x03, 
                        LNKD, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x001EFFFF, 
                        Zero, 
                        LNKA, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x001EFFFF, 
                        One, 
                        LNKB, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x001EFFFF, 
                        0x02, 
                        LNKC, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x001EFFFF, 
                        0x03, 
                        LNKD, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x001DFFFF, 
                        Zero, 
                        LNKE, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x001DFFFF, 
                        One, 
                        LNKF, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x001DFFFF, 
                        0x02, 
                        LNKG, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x001DFFFF, 
                        0x03, 
                        LNKH, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x001AFFFF, 
                        Zero, 
                        LNKE, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x001AFFFF, 
                        One, 
                        LNKF, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x001AFFFF, 
                        0x02, 
                        LNKG, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x001AFFFF, 
                        0x03, 
                        LNKH, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x001CFFFF, 
                        Zero, 
                        LNKA, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x001CFFFF, 
                        One, 
                        LNKB, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x001CFFFF, 
                        0x02, 
                        LNKC, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x001CFFFF, 
                        0x03, 
                        LNKD, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x001BFFFF, 
                        Zero, 
                        LNKF, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x0019FFFF, 
                        Zero, 
                        LNKG, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x0003FFFF, 
                        Zero, 
                        LNKA, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x0003FFFF, 
                        One, 
                        LNKB, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x0003FFFF, 
                        0x02, 
                        LNKC, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x0003FFFF, 
                        0x03, 
                        LNKD, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x0001FFFF, 
                        Zero, 
                        LNKA, 
                        Zero
                    }
                })
                Name (API0, Package (0x1C)
                {
                    Package (0x04)
                    {
                        0x001FFFFF, 
                        One, 
                        Zero, 
                        0x13
                    }, 

                    Package (0x04)
                    {
                        0x001FFFFF, 
                        Zero, 
                        Zero, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0x001FFFFF, 
                        One, 
                        Zero, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0x001FFFFF, 
                        0x02, 
                        Zero, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0x001FFFFF, 
                        0x03, 
                        Zero, 
                        0x13
                    }, 

                    Package (0x04)
                    {
                        0x001EFFFF, 
                        Zero, 
                        Zero, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0x001EFFFF, 
                        One, 
                        Zero, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0x001EFFFF, 
                        0x02, 
                        Zero, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0x001EFFFF, 
                        0x03, 
                        Zero, 
                        0x13
                    }, 

                    Package (0x04)
                    {
                        0x001DFFFF, 
                        Zero, 
                        Zero, 
                        0x14
                    }, 

                    Package (0x04)
                    {
                        0x001DFFFF, 
                        One, 
                        Zero, 
                        0x15
                    }, 

                    Package (0x04)
                    {
                        0x001DFFFF, 
                        0x02, 
                        Zero, 
                        0x16
                    }, 

                    Package (0x04)
                    {
                        0x001DFFFF, 
                        0x03, 
                        Zero, 
                        0x17
                    }, 

                    Package (0x04)
                    {
                        0x001AFFFF, 
                        Zero, 
                        Zero, 
                        0x14
                    }, 

                    Package (0x04)
                    {
                        0x001AFFFF, 
                        One, 
                        Zero, 
                        0x15
                    }, 

                    Package (0x04)
                    {
                        0x001AFFFF, 
                        0x02, 
                        Zero, 
                        0x16
                    }, 

                    Package (0x04)
                    {
                        0x001AFFFF, 
                        0x03, 
                        Zero, 
                        0x17
                    }, 

                    Package (0x04)
                    {
                        0x001CFFFF, 
                        Zero, 
                        Zero, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0x001CFFFF, 
                        One, 
                        Zero, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0x001CFFFF, 
                        0x02, 
                        Zero, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0x001CFFFF, 
                        0x03, 
                        Zero, 
                        0x13
                    }, 

                    Package (0x04)
                    {
                        0x001BFFFF, 
                        Zero, 
                        Zero, 
                        0x15
                    }, 

                    Package (0x04)
                    {
                        0x0019FFFF, 
                        Zero, 
                        Zero, 
                        0x16
                    }, 

                    Package (0x04)
                    {
                        0x0003FFFF, 
                        Zero, 
                        Zero, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0x0003FFFF, 
                        One, 
                        Zero, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0x0003FFFF, 
                        0x02, 
                        Zero, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0x0003FFFF, 
                        0x03, 
                        Zero, 
                        0x14
                    }, 

                    Package (0x04)
                    {
                        0x0001FFFF, 
                        Zero, 
                        Zero, 
                        0x10
                    }
                })
                Method (_PRT, 0, NotSerialized)
                {
                    Store (API0, Local0)
                    If (LNot (GPIC))
                    {
                        Store (PIC0, Local0)
                    }

                    Return (Local0)
                }

                Field (ISAB.PIR1, ByteAcc, NoLock, Preserve)
                {
                    PIRA,   8, 
                    PIRB,   8, 
                    PIRC,   8, 
                    PIRD,   8
                }

                Field (ISAB.PIR2, ByteAcc, NoLock, Preserve)
                {
                    PIRE,   8, 
                    PIRF,   8, 
                    PIRG,   8, 
                    PIRH,   8
                }

                Device (LNKA)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, One)
                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {10,11}
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        Store (PIRA, Local0)
                        And (Local0, 0x80, Local0)
                        If (LEqual (Local0, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (PIRA, Local0)
                        Or (Local0, 0x80, Local0)
                        Store (Local0, PIRA)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUFA, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {}
                        })
                        CreateWordField (BUFA, One, IRA)
                        Store (PIRA, Local0)
                        And (Local0, 0x8F, Local0)
                        If (LLess (Local0, 0x80))
                        {
                            And (Local0, 0x0F, Local0)
                            Store (One, Local1)
                            ShiftLeft (Local1, Local0, Local1)
                            Store (Local1, IRA)
                        }

                        Return (BUFA)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, One, IRQA)
                        FindSetLeftBit (IRQA, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRA)
                    }
                }

                Device (LNKB)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x02)
                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {5,7}
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        Store (PIRB, Local0)
                        And (Local0, 0x80, Local0)
                        If (LEqual (Local0, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (PIRB, Local0)
                        Or (Local0, 0x80, Local0)
                        Store (Local0, PIRB)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUFB, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {}
                        })
                        CreateWordField (BUFB, One, IRB)
                        Store (PIRB, Local0)
                        And (Local0, 0x8F, Local0)
                        If (LLess (Local0, 0x80))
                        {
                            And (Local0, 0x0F, Local0)
                            Store (One, Local1)
                            ShiftLeft (Local1, Local0, Local1)
                            Store (Local1, IRB)
                        }

                        Return (BUFB)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, One, IRQB)
                        FindSetLeftBit (IRQB, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRB)
                    }
                }

                Device (LNKC)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x03)
                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {10,11}
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        Store (PIRC, Local0)
                        And (Local0, 0x80, Local0)
                        If (LEqual (Local0, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (PIRC, Local0)
                        Or (Local0, 0x80, Local0)
                        Store (Local0, PIRC)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUFC, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {}
                        })
                        CreateWordField (BUFC, One, IRC)
                        Store (PIRC, Local0)
                        And (Local0, 0x8F, Local0)
                        If (LLess (Local0, 0x80))
                        {
                            And (Local0, 0x0F, Local0)
                            Store (One, Local1)
                            ShiftLeft (Local1, Local0, Local1)
                            Store (Local1, IRC)
                        }

                        Return (BUFC)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, One, IRQC)
                        FindSetLeftBit (IRQC, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRC)
                    }
                }

                Device (LNKD)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x04)
                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {5,7,10,11}
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        Store (PIRD, Local0)
                        And (Local0, 0x80, Local0)
                        If (LEqual (Local0, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (PIRD, Local0)
                        Or (Local0, 0x80, Local0)
                        Store (Local0, PIRD)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUFD, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {}
                        })
                        CreateWordField (BUFD, One, IRD)
                        Store (PIRD, Local0)
                        And (Local0, 0x8F, Local0)
                        If (LLess (Local0, 0x80))
                        {
                            And (Local0, 0x0F, Local0)
                            Store (One, Local1)
                            ShiftLeft (Local1, Local0, Local1)
                            Store (Local1, IRD)
                        }

                        Return (BUFD)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, One, IRQD)
                        FindSetLeftBit (IRQD, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRD)
                    }
                }

                Device (LNKE)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x05)
                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {3,4,5,6,7,10,11,12,14,15}
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        Store (PIRE, Local0)
                        And (Local0, 0x80, Local0)
                        If (LEqual (Local0, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (PIRE, Local0)
                        Or (Local0, 0x80, Local0)
                        Store (Local0, PIRE)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUFE, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {}
                        })
                        CreateWordField (BUFE, One, IRE)
                        Store (PIRE, Local0)
                        And (Local0, 0x8F, Local0)
                        If (LLess (Local0, 0x80))
                        {
                            And (Local0, 0x0F, Local0)
                            Store (One, Local1)
                            ShiftLeft (Local1, Local0, Local1)
                            Store (Local1, IRE)
                        }

                        Return (BUFE)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, One, IRQE)
                        FindSetLeftBit (IRQE, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRE)
                    }
                }

                Device (LNKF)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x06)
                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {3,4,5,6,7,10,11,12,14,15}
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        Store (PIRF, Local0)
                        And (Local0, 0x80, Local0)
                        If (LEqual (Local0, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (PIRF, Local0)
                        Or (Local0, 0x80, Local0)
                        Store (Local0, PIRF)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUFF, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {}
                        })
                        CreateWordField (BUFF, One, IRF)
                        Store (PIRF, Local0)
                        And (Local0, 0x8F, Local0)
                        If (LLess (Local0, 0x80))
                        {
                            And (Local0, 0x0F, Local0)
                            Store (One, Local1)
                            ShiftLeft (Local1, Local0, Local1)
                            Store (Local1, IRF)
                        }

                        Return (BUFF)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, One, IRQF)
                        FindSetLeftBit (IRQF, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRF)
                    }
                }

                Device (LNKG)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x07)
                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {3,4,5,6,7,10,11,12,14,15}
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        Store (PIRG, Local0)
                        And (Local0, 0x80, Local0)
                        If (LEqual (Local0, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (PIRG, Local0)
                        Or (Local0, 0x80, Local0)
                        Store (Local0, PIRG)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUFG, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {}
                        })
                        CreateWordField (BUFG, One, IRG)
                        Store (PIRG, Local0)
                        And (Local0, 0x8F, Local0)
                        If (LLess (Local0, 0x80))
                        {
                            And (Local0, 0x0F, Local0)
                            Store (One, Local1)
                            ShiftLeft (Local1, Local0, Local1)
                            Store (Local1, IRG)
                        }

                        Return (BUFG)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, One, IRQG)
                        FindSetLeftBit (IRQG, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRG)
                    }
                }

                Device (LNKH)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x08)
                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {3,4,5,6,7,10,11,12,14,15}
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        Store (PIRH, Local0)
                        And (Local0, 0x80, Local0)
                        If (LEqual (Local0, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (PIRH, Local0)
                        Or (Local0, 0x80, Local0)
                        Store (Local0, PIRH)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUFH, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {}
                        })
                        CreateWordField (BUFH, One, IRH)
                        Store (PIRH, Local0)
                        And (Local0, 0x8F, Local0)
                        If (LLess (Local0, 0x80))
                        {
                            And (Local0, 0x0F, Local0)
                            Store (One, Local1)
                            ShiftLeft (Local1, Local0, Local1)
                            Store (Local1, IRH)
                        }

                        Return (BUFH)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, One, IRQH)
                        FindSetLeftBit (IRQH, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRH)
                    }
                }
            }

            Scope (AGP)
            {
                Name (PIC1, Package (0x01)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        LNKA, 
                        Zero
                    }
                })
                Name (API1, Package (0x01)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x10
                    }
                })
                Method (_PRT, 0, NotSerialized)
                {
                    Store (API1, Local0)
                    If (LNot (GPIC))
                    {
                        Store (PIC1, Local0)
                    }

                    Return (Local0)
                }
            }

            Scope (PCIE)
            {
                Name (PICE, Package (0x04)
                {
                    Package (0x04)
                    {
                        0x0001FFFF, 
                        Zero, 
                        LNKD, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x0001FFFF, 
                        One, 
                        LNKB, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x0001FFFF, 
                        0x02, 
                        LNKC, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        LNKB, 
                        Zero
                    }
                })
                Name (APIE, Package (0x04)
                {
                    Package (0x04)
                    {
                        0x0001FFFF, 
                        Zero, 
                        Zero, 
                        0x13
                    }, 

                    Package (0x04)
                    {
                        0x0001FFFF, 
                        One, 
                        Zero, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0x0001FFFF, 
                        0x02, 
                        Zero, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x11
                    }
                })
                Method (_PRT, 0, NotSerialized)
                {
                    Store (APIE, Local0)
                    If (LNot (GPIC))
                    {
                        Store (PICE, Local0)
                    }

                    Return (Local0)
                }
            }
        }

        Scope (\_SB)
        {
            Device (LID)
            {
                Name (_HID, EisaId ("PNP0C0D"))
                Method (_LID, 0, NotSerialized)
                {
                    If (LEqual (MIS7, One))
                    {
                        Store (Zero, MIS7)
                        Store (One, Local0)
                    }
                    Else
                    {
                        Store (ECG3 (), Local0)
                    }

                    Return (Local0)
                }

                Name (_PRW, Package (0x02)
                {
                    0x17, 
                    0x03
                })
                Method (_PSW, 1, NotSerialized)
                {
                    PSW (Arg0, 0x02)
                }
            }

            Device (PBTN)
            {
                Name (_HID, EisaId ("PNP0C0C"))
                Name (_PRW, Package (0x02)
                {
                    0x17, 
                    0x04
                })
                Method (_PSW, 1, NotSerialized)
                {
                    PSW (Arg0, One)
                }
            }

            Device (SBTN)
            {
                Name (_HID, EisaId ("PNP0C0E"))
            }
        }

        Device (AC)
        {
            Name (_HID, "ACPI0003")
            Name (_PCL, Package (0x03)
            {
                _SB, 
                BAT0, 
                BAT1
            })
            Method (_PSR, 0, NotSerialized)
            {
                And (MIS0, One, Local0)
                Return (Local0)
            }

            Method (_STA, 0, NotSerialized)
            {
                Return (0x0F)
            }
        }

        Device (BAT0)
        {
            Name (_HID, EisaId ("PNP0C0A"))
            Name (_UID, One)
            Name (_PCL, Package (0x01)
            {
                _SB
            })
            Method (_STA, 0, NotSerialized)
            {
                And (MIS0, 0x02, Local0)
                If (Local0)
                {
                    Return (0x1F)
                }

                Return (0x0F)
            }

            Method (_BIF, 0, NotSerialized)
            {
                Name (BIF0, Package (0x0D) {})
                ECG9 (One, BIF0)
                Return (BIF0)
            }

            Method (_BST, 0, NotSerialized)
            {
                Name (BST0, Package (0x04) {})
                ECG6 (One, BST0)
                Return (BST0)
            }
        }

        Device (BAT1)
        {
            Name (_HID, EisaId ("PNP0C0A"))
            Name (_UID, 0x02)
            Name (_PCL, Package (0x01)
            {
                _SB
            })
            Method (_STA, 0, NotSerialized)
            {
                And (MIS0, 0x10, Local0)
                If (Local0)
                {
                    Return (0x1F)
                }

                Return (0x0F)
            }

            Method (_BIF, 0, NotSerialized)
            {
                Name (BIF1, Package (0x0D) {})
                ECG9 (0x02, BIF1)
                Return (BIF1)
            }

            Method (_BST, 0, NotSerialized)
            {
                Name (BST1, Package (0x04) {})
                ECG6 (0x02, BST1)
                Return (BST1)
            }
        }

        Device (AMW0)
        {
            Mutex (WMIX, 0x01)
            Name (_HID, "pnp0c14")
            Name (_UID, Zero)
            Method (STBY, 3, NotSerialized)
            {
                CreateByteField (Arg0, Arg1, TMP)
                Store (Arg2, TMP)
            }

            Method (STWD, 3, NotSerialized)
            {
                CreateWordField (Arg0, Arg1, TMP)
                Store (Arg2, TMP)
            }

            Method (STDW, 3, NotSerialized)
            {
                CreateDWordField (Arg0, Arg1, TMP)
                Store (Arg2, TMP)
            }

            Method (CLBY, 1, NotSerialized)
            {
                Store (Zero, Local0)
                While (LLess (Local0, SizeOf (Arg0)))
                {
                    STBY (Arg0, Local0, Zero)
                    Increment (Local0)
                }
            }

            Name (_WDG, Buffer (0x78)
            {
                /* 0000 */    0xBC, 0xDC, 0x9D, 0x8D, 0x97, 0xA9, 0xDA, 0x11, 
                /* 0008 */    0xB0, 0x12, 0xB6, 0x22, 0xA1, 0xEF, 0x54, 0x92, 
                /* 0010 */    0x41, 0x41, 0x01, 0x00, 0xCE, 0x93, 0x05, 0xA8, 
                /* 0018 */    0x97, 0xA9, 0xDA, 0x11, 0xB0, 0x12, 0xB6, 0x22, 
                /* 0020 */    0xA1, 0xEF, 0x54, 0x92, 0x42, 0x41, 0x01, 0x02, 
                /* 0028 */    0x94, 0x59, 0xBB, 0x9D, 0x97, 0xA9, 0xDA, 0x11, 
                /* 0030 */    0xB0, 0x12, 0xB6, 0x22, 0xA1, 0xEF, 0x54, 0x92, 
                /* 0038 */    0xD0, 0x00, 0x01, 0x08, 0xE0, 0x6C, 0x77, 0xA3, 
                /* 0040 */    0x88, 0x1E, 0xDB, 0x11, 0xA9, 0x8B, 0x08, 0x00, 
                /* 0048 */    0x20, 0x0C, 0x9A, 0x66, 0x42, 0x43, 0x01, 0x00, 
                /* 0050 */    0x21, 0x12, 0x90, 0x05, 0x66, 0xD5, 0xD1, 0x11, 
                /* 0058 */    0xB2, 0xF0, 0x00, 0xA0, 0xC9, 0x06, 0x29, 0x10, 
                /* 0060 */    0x4D, 0x4F, 0x01, 0x00, 0x28, 0x07, 0xBD, 0x77, 
                /* 0068 */    0x34, 0x2E, 0x8C, 0x47, 0xB6, 0x25, 0x67, 0xF0, 
                /* 0070 */    0x2A, 0x7E, 0x48, 0x97, 0x42, 0x44, 0x01, 0x02
            })
            Name (INFO, Buffer (0x80) {})
            Name (ECD0, Zero)
            Method (WED0, 1, NotSerialized)
            {
                Store (Arg0, ECD0)
                Return (Zero)
            }

            Method (WCAA, 1, NotSerialized)
            {
                Return (Zero)
            }

            Method (WQAA, 1, NotSerialized)
            {
                Acquire (WMIX, 0xFFFF)
                CLBY (INFO)
                If (LNotEqual (Arg0, Zero))
                {
                    Store (INFO, Local1)
                }
                Else
                {
                    STDW (INFO, Zero, 0x4C4C4544)
                    STDW (INFO, 0x04, 0x494D5720)
                    STDW (INFO, 0x08, One)
                    STDW (INFO, 0x0C, 0x1000)
                    Store (INFO, Local1)
                }

                Release (WMIX)
                Return (Local1)
            }

            Method (WSAA, 2, NotSerialized)
            {
                Return (Arg1)
            }

            Method (WMBA, 3, NotSerialized)
            {
                CreateDWordField (Arg2, 0x28, WBUF)
                Add (WBUF, 0x2C, Local1)
                If (LLessEqual (Local1, 0x1000))
                {
                    Store (WMI (Arg2, Local1, 0xCC), Local0)
                }

                Return (Local0)
            }

            Method (WMBD, 3, NotSerialized)
            {
                CreateDWordField (Arg2, Zero, WBUF)
                If (LLessEqual (WBUF, 0x1000))
                {
                    Store (WMI (Arg2, WBUF, 0x5F), Local0)
                }

                Return (Local0)
            }

            Name (WMI1, Zero)
            Name (WMI2, Buffer (0x80) {})
            Name (WMI3, Zero)
            Method (WMI4, 1, NotSerialized)
            {
                Or (WMI1, Arg0, WMI1)
            }

            Method (WMI5, 1, NotSerialized)
            {
                And (WMI1, Not (Arg0), WMI1)
            }

            Method (WMI6, 0, NotSerialized)
            {
                Acquire (WMIX, 0xFFFF)
                Store (Zero, WMI3)
                CLBY (WMI2)
            }

            Method (WMI7, 0, NotSerialized)
            {
                Acquire (WMIX, 0xFFFF)
                Store (Zero, WMI3)
            }

            Method (WMI8, 1, NotSerialized)
            {
                Store (WMI3, Local0)
                Add (Local0, 0x02, Local0)
                If (LLessEqual (Local0, SizeOf (WMI2)))
                {
                    CreateWordField (WMI2, WMI3, WMI9)
                    Store (Arg0, WMI9)
                    Store (Local0, WMI3)
                }
            }

            Method (_WED, 1, NotSerialized)
            {
                WMI6 ()
                If (LNotEqual (Arg0, 0xD0))
                {
                    WMI7 ()
                    Return (WMI2)
                }

                If (LEqual (ECD0, Zero))
                {
                    WMI7 ()
                    Return (WMI2)
                }
                Else
                {
                    If (And (WMI1, 0x0800))
                    {
                        Store (EC0A (WMI2), WMI2)
                        WMI5 (0x0800)
                    }
                }

                WMI7 ()
                Return (WMI2)
            }

            Name (WQMO, Buffer (0x06CD)
            {
                /* 0000 */    0x46, 0x4F, 0x4D, 0x42, 0x01, 0x00, 0x00, 0x00, 
                /* 0008 */    0xBD, 0x06, 0x00, 0x00, 0x66, 0x23, 0x00, 0x00, 
                /* 0010 */    0x44, 0x53, 0x00, 0x01, 0x1A, 0x7D, 0xDA, 0x54, 
                /* 0018 */    0x98, 0x40, 0x91, 0x00, 0x01, 0x06, 0x18, 0x42, 
                /* 0020 */    0x10, 0x11, 0x10, 0x22, 0x21, 0x30, 0x34, 0x32, 
                /* 0028 */    0x0B, 0x03, 0x63, 0x04, 0x8A, 0x0B, 0x21, 0x07, 
                /* 0030 */    0x10, 0x12, 0x07, 0x85, 0x12, 0x02, 0xA1, 0xFE, 
                /* 0038 */    0x04, 0xF2, 0x2B, 0x00, 0xA1, 0x43, 0x01, 0x32, 
                /* 0040 */    0x05, 0x18, 0x14, 0xE0, 0x14, 0x41, 0x04, 0xBD, 
                /* 0048 */    0x0A, 0xB0, 0x29, 0xC0, 0xA4, 0x00, 0x8B, 0x02, 
                /* 0050 */    0xB4, 0x0B, 0xB0, 0x2C, 0x40, 0xB7, 0x00, 0xE9, 
                /* 0058 */    0xB0, 0x44, 0x24, 0x38, 0x4A, 0x0C, 0x38, 0x4A, 
                /* 0060 */    0x27, 0xB6, 0x70, 0xC3, 0x06, 0x2F, 0x14, 0x45, 
                /* 0068 */    0x33, 0x88, 0x92, 0xA0, 0x72, 0x01, 0xBE, 0x11, 
                /* 0070 */    0x04, 0x5E, 0xAE, 0x00, 0xC9, 0x13, 0x90, 0x66, 
                /* 0078 */    0x01, 0x86, 0x05, 0x58, 0x17, 0x20, 0x7B, 0x08, 
                /* 0080 */    0x54, 0xEA, 0x10, 0x50, 0x72, 0x86, 0x80, 0x1A, 
                /* 0088 */    0x40, 0xAB, 0x13, 0x10, 0x7E, 0xA5, 0x53, 0x42, 
                /* 0090 */    0x12, 0x84, 0x33, 0x56, 0xF1, 0xF8, 0x9A, 0x45, 
                /* 0098 */    0xD3, 0x73, 0x92, 0x73, 0x0C, 0x39, 0x1E, 0x17, 
                /* 00A0 */    0x7A, 0x10, 0x3C, 0x90, 0x02, 0x10, 0x16, 0x1E, 
                /* 00A8 */    0x42, 0x11, 0x60, 0x50, 0x12, 0xC6, 0x42, 0x5D, 
                /* 00B0 */    0x8C, 0x1A, 0x35, 0x52, 0x36, 0x20, 0x43, 0x94, 
                /* 00B8 */    0x36, 0x6A, 0xF4, 0x80, 0xCE, 0xEF, 0x48, 0xCE, 
                /* 00C0 */    0xEE, 0xE8, 0x8E, 0x24, 0x81, 0x51, 0x8F, 0xE9, 
                /* 00C8 */    0x18, 0x0B, 0x9B, 0x91, 0x50, 0x63, 0x34, 0x07, 
                /* 00D0 */    0x45, 0xA0, 0x71, 0x83, 0xB6, 0x44, 0x58, 0x8D, 
                /* 00D8 */    0x2B, 0xF6, 0x99, 0x59, 0xF8, 0xB0, 0x84, 0x71, 
                /* 00E0 */    0x04, 0x07, 0x96, 0xA0, 0x51, 0x34, 0xCD, 0xF1, 
                /* 00E8 */    0x6C, 0x43, 0x24, 0x38, 0x88, 0xD0, 0x18, 0x19, 
                /* 00F0 */    0x10, 0xF2, 0x3C, 0x6C, 0x81, 0x1E, 0x79, 0x02, 
                /* 00F8 */    0xBB, 0x47, 0x94, 0x42, 0x04, 0xCD, 0xF7, 0x44, 
                /* 0100 */    0x6A, 0x14, 0xA0, 0x0D, 0x43, 0xB6, 0xCE, 0x06, 
                /* 0108 */    0x1A, 0x6A, 0xAC, 0xC6, 0x50, 0x04, 0x11, 0x21, 
                /* 0110 */    0x68, 0x14, 0x83, 0x45, 0x08, 0x15, 0xE2, 0xFF, 
                /* 0118 */    0x1F, 0x25, 0xEA, 0x29, 0x05, 0x89, 0x5A, 0x19, 
                /* 0120 */    0x88, 0xD0, 0x82, 0x19, 0x81, 0xD9, 0x1F, 0x04, 
                /* 0128 */    0x89, 0x71, 0x66, 0xD0, 0x61, 0xC1, 0x32, 0x40, 
                /* 0130 */    0x64, 0x44, 0xD0, 0x68, 0xD8, 0x59, 0xC0, 0xC3, 
                /* 0138 */    0xF1, 0x4C, 0x9A, 0x9F, 0x98, 0x06, 0x67, 0x82, 
                /* 0140 */    0xB1, 0x21, 0xA4, 0x01, 0x42, 0xA2, 0x0E, 0x0E, 
                /* 0148 */    0x94, 0xC0, 0x52, 0x06, 0x4E, 0x6C, 0x8F, 0x4B, 
                /* 0150 */    0xE3, 0x3B, 0xE3, 0xA8, 0x21, 0x4E, 0xFD, 0xCC, 
                /* 0158 */    0xFC, 0x8F, 0xF0, 0x16, 0x7C, 0x04, 0xE0, 0x63, 
                /* 0160 */    0xF0, 0x60, 0x0F, 0x21, 0xE0, 0x11, 0xB2, 0x33, 
                /* 0168 */    0x80, 0x01, 0xF1, 0xDE, 0x27, 0x4D, 0xE6, 0xE2, 
                /* 0170 */    0xB3, 0x00, 0x8C, 0xE1, 0xC3, 0x35, 0x3E, 0x0A, 
                /* 0178 */    0x8D, 0x87, 0x9D, 0x0F, 0xD8, 0xB8, 0x38, 0xBC, 
                /* 0180 */    0x0F, 0x05, 0x27, 0x5C, 0x2C, 0x88, 0x02, 0x40, 
                /* 0188 */    0x48, 0xD6, 0xF9, 0x00, 0x3D, 0xEB, 0x63, 0x0B, 
                /* 0190 */    0xF8, 0x30, 0xD0, 0xEC, 0x1D, 0x82, 0x10, 0xBC, 
                /* 0198 */    0x08, 0xF8, 0xE8, 0xE0, 0xE3, 0x86, 0xC7, 0xFD, 
                /* 01A0 */    0xBC, 0x01, 0x86, 0xC3, 0x81, 0x87, 0xE3, 0xD3, 
                /* 01A8 */    0x06, 0x70, 0x19, 0x01, 0x97, 0xF6, 0xA4, 0x30, 
                /* 01B0 */    0x81, 0x24, 0x3F, 0x01, 0x24, 0x06, 0x06, 0x75, 
                /* 01B8 */    0x20, 0xF0, 0xC1, 0x02, 0xAE, 0x24, 0x38, 0xD4, 
                /* 01C0 */    0xF0, 0x3C, 0xB1, 0x07, 0x84, 0xFF, 0xFF, 0x51, 
                /* 01C8 */    0x9E, 0xC8, 0x8B, 0x81, 0xA7, 0xFF, 0x18, 0x00, 
                /* 01D0 */    0xE3, 0x80, 0xE0, 0x69, 0x9D, 0x94, 0x6F, 0x1E, 
                /* 01D8 */    0x0F, 0x12, 0x1E, 0x54, 0x98, 0x04, 0x3E, 0x25, 
                /* 01E0 */    0x30, 0x34, 0x7E, 0xDC, 0x00, 0xEB, 0xA8, 0xF1, 
                /* 01E8 */    0x07, 0x04, 0x78, 0x27, 0x89, 0xF3, 0xEB, 0x73, 
                /* 01F0 */    0x00, 0x3A, 0x34, 0x9C, 0x22, 0x03, 0x79, 0x0D, 
                /* 01F8 */    0x38, 0xE9, 0x53, 0xF2, 0xF8, 0x12, 0xF8, 0xCC, 
                /* 0200 */    0x01, 0xFB, 0x6E, 0x70, 0x18, 0x07, 0x13, 0x22, 
                /* 0208 */    0xC2, 0x7B, 0xC0, 0x53, 0x87, 0xEF, 0x1A, 0x8F, 
                /* 0210 */    0x02, 0x81, 0x22, 0xF4, 0x76, 0xE6, 0xA0, 0xA7, 
                /* 0218 */    0x10, 0xA3, 0x44, 0x3B, 0xAB, 0x30, 0x0F, 0x1C, 
                /* 0220 */    0x51, 0x7C, 0xE4, 0x30, 0xC2, 0xBB, 0x87, 0xEF, 
                /* 0228 */    0x04, 0x0F, 0x20, 0xAD, 0x4D, 0x4E, 0xB8, 0x81, 
                /* 0230 */    0x9E, 0x39, 0x58, 0xB4, 0x33, 0x8B, 0x2C, 0x80, 
                /* 0238 */    0x28, 0xD2, 0x68, 0x50, 0x67, 0x04, 0x9F, 0x06, 
                /* 0240 */    0x3C, 0xAD, 0xA7, 0x18, 0x1F, 0x25, 0x0C, 0x72, 
                /* 0248 */    0x86, 0x07, 0xF6, 0x9C, 0xF0, 0x18, 0xE0, 0x01, 
                /* 0250 */    0xB3, 0xFB, 0x81, 0x8F, 0x13, 0x3E, 0x17, 0xE0, 
                /* 0258 */    0x5D, 0x03, 0x6A, 0x86, 0x3E, 0x6C, 0xC0, 0x39, 
                /* 0260 */    0x74, 0xE0, 0x4F, 0x13, 0xF8, 0x83, 0x05, 0x7E, 
                /* 0268 */    0x3C, 0xBE, 0xE6, 0xB0, 0x09, 0x27, 0xB0, 0xFC, 
                /* 0270 */    0x41, 0xA0, 0x46, 0x66, 0x68, 0xCF, 0xF2, 0xB4, 
                /* 0278 */    0x5E, 0x03, 0x7C, 0xDA, 0x31, 0x81, 0xCF, 0x1B, 
                /* 0280 */    0xFE, 0xFF, 0xFF, 0x73, 0x3C, 0x1E, 0xF0, 0x2B, 
                /* 0288 */    0x3E, 0x5D, 0x90, 0xBB, 0x82, 0xE7, 0xEB, 0xB3, 
                /* 0290 */    0x0B, 0xB3, 0x31, 0x1E, 0xD4, 0x28, 0x7C, 0xC0, 
                /* 0298 */    0xC1, 0x9D, 0x5D, 0x7C, 0x04, 0xF0, 0xD9, 0x05, 
                /* 02A0 */    0x78, 0x4E, 0xE2, 0x59, 0x02, 0xBC, 0x87, 0x00, 
                /* 02A8 */    0x9F, 0x48, 0xE2, 0x3D, 0x6C, 0xC1, 0x18, 0x31, 
                /* 02B0 */    0x1E, 0xF2, 0x8C, 0xAB, 0x1E, 0x86, 0x2E, 0x02, 
                /* 02B8 */    0x56, 0x77, 0x5F, 0x41, 0x1D, 0xBD, 0xC0, 0x04, 
                /* 02C0 */    0xF5, 0x9A, 0x81, 0x3B, 0xBD, 0x00, 0x9F, 0x53, 
                /* 02C8 */    0x16, 0xBC, 0xFF, 0xFF, 0x29, 0x0B, 0xB8, 0x5F, 
                /* 02D0 */    0x15, 0xF8, 0x11, 0x05, 0x0C, 0x90, 0x9D, 0x9D, 
                /* 02D8 */    0x4E, 0x84, 0xF0, 0x5E, 0xF2, 0x1C, 0xE2, 0xDB, 
                /* 02E0 */    0x95, 0x0F, 0x26, 0x41, 0x9E, 0x03, 0x22, 0x3C, 
                /* 02E8 */    0x65, 0xF1, 0xFB, 0x40, 0x94, 0x98, 0x07, 0x14, 
                /* 02F0 */    0x29, 0x8A, 0x11, 0x83, 0x3C, 0x61, 0xF9, 0x7A, 
                /* 02F8 */    0x12, 0xC3, 0xD0, 0xC1, 0xC2, 0x85, 0x8F, 0xF0, 
                /* 0300 */    0x94, 0x05, 0x58, 0xBC, 0x64, 0x61, 0x4E, 0x59, 
                /* 0308 */    0x30, 0xDF, 0x06, 0x3E, 0x65, 0x81, 0xE3, 0xFF, 
                /* 0310 */    0x7F, 0xCA, 0x02, 0xD7, 0xB8, 0x9F, 0xB2, 0x80, 
                /* 0318 */    0x99, 0xF4, 0xA7, 0x80, 0x4F, 0x35, 0x7E, 0x02, 
                /* 0320 */    0x28, 0xFA, 0xC1, 0x82, 0xC2, 0xF8, 0x94, 0x05, 
                /* 0328 */    0xB8, 0x92, 0x77, 0x40, 0x00, 0xCD, 0xD9, 0xC9, 
                /* 0330 */    0xB7, 0x05, 0x83, 0x1D, 0xB3, 0x2F, 0x19, 0x3E, 
                /* 0338 */    0x25, 0x82, 0xE1, 0x90, 0xE1, 0x3B, 0xD5, 0xA1, 
                /* 0340 */    0x3C, 0x72, 0x3C, 0x05, 0xF8, 0x88, 0x05, 0xF6, 
                /* 0348 */    0x38, 0xC7, 0x00, 0x1D, 0x57, 0x7C, 0xC4, 0xF2, 
                /* 0350 */    0xFF, 0xFF, 0x88, 0x05, 0x70, 0xE3, 0x00, 0x82, 
                /* 0358 */    0x3F, 0x75, 0xC0, 0xBA, 0x07, 0x84, 0xF5, 0xA1, 
                /* 0360 */    0x03, 0x78, 0xC8, 0x7E, 0x08, 0xE8, 0x0C, 0x63, 
                /* 0368 */    0xC9, 0x20, 0xB2, 0x71, 0xAE, 0xA1, 0x63, 0xB4, 
                /* 0370 */    0xF8, 0x85, 0xEA, 0xA6, 0x10, 0xFB, 0x60, 0xB8, 
                /* 0378 */    0x6C, 0x20, 0x81, 0x7A, 0xB8, 0x16, 0x4C, 0x21, 
                /* 0380 */    0x51, 0x34, 0x1A, 0x8D, 0x81, 0x09, 0x8C, 0xE0, 
                /* 0388 */    0x0C, 0x62, 0x40, 0x67, 0x84, 0xD0, 0xA1, 0x0C, 
                /* 0390 */    0xA7, 0xE2, 0x3C, 0x84, 0xFA, 0xFF, 0x13, 0x0C, 
                /* 0398 */    0x75, 0x63, 0xA2, 0xB3, 0xF3, 0xFC, 0xF9, 0x6D, 
                /* 03A0 */    0xC4, 0x27, 0x02, 0x03, 0xFB, 0x0A, 0xF1, 0x96, 
                /* 03A8 */    0x01, 0x96, 0x61, 0x79, 0x71, 0x4F, 0x00, 0xC7, 
                /* 03B0 */    0x78, 0x92, 0x09, 0xAA, 0x39, 0xD6, 0xA0, 0xE6, 
                /* 03B8 */    0xE0, 0xAB, 0xC0, 0x1B, 0x99, 0x09, 0x7C, 0x05, 
                /* 03C0 */    0x03, 0xDB, 0x69, 0x06, 0xA3, 0xEF, 0x4E, 0x00, 
                /* 03C8 */    0x0A, 0x20, 0x1F, 0x05, 0x7C, 0x5F, 0x7E, 0x1B, 
                /* 03D0 */    0x60, 0xB3, 0x78, 0x65, 0x36, 0x9A, 0xCF, 0x9F, 
                /* 03D8 */    0x88, 0xA1, 0xA3, 0xC4, 0x0C, 0x9D, 0x82, 0x78, 
                /* 03E0 */    0xE8, 0x0E, 0x3A, 0x74, 0xF4, 0x71, 0xC0, 0x27, 
                /* 03E8 */    0x2B, 0x5C, 0xB0, 0xC3, 0x17, 0xB4, 0xC9, 0x1D, 
                /* 03F0 */    0xED, 0x89, 0x79, 0x16, 0x9E, 0x27, 0x6E, 0xEE, 
                /* 03F8 */    0x60, 0x3A, 0x22, 0xC1, 0x18, 0x3C, 0x66, 0xF2, 
                /* 0400 */    0x60, 0x16, 0x38, 0x79, 0x50, 0xFC, 0xFF, 0x27, 
                /* 0408 */    0x0F, 0x13, 0x1E, 0x13, 0xF6, 0x70, 0x48, 0x0F, 
                /* 0410 */    0x1D, 0x1E, 0x19, 0x1F, 0xA7, 0x4F, 0x3F, 0x0C, 
                /* 0418 */    0xFB, 0x74, 0xCE, 0xA5, 0xE8, 0x19, 0xE9, 0x8E, 
                /* 0420 */    0xF1, 0xCC, 0x85, 0x81, 0xF5, 0xC8, 0x39, 0xAC, 
                /* 0428 */    0xD1, 0xC2, 0x1E, 0xF0, 0x73, 0x88, 0xEF, 0x30, 
                /* 0430 */    0x3E, 0xF0, 0x30, 0x58, 0x9F, 0x5E, 0xC0, 0x71, 
                /* 0438 */    0xFC, 0x82, 0x7F, 0x1A, 0x00, 0xCF, 0x01, 0xC4, 
                /* 0440 */    0x63, 0x78, 0x01, 0xE1, 0x04, 0x73, 0x9D, 0xA6, 
                /* 0448 */    0x50, 0xF1, 0x4F, 0x53, 0x80, 0xF6, 0xFF, 0xFF, 
                /* 0450 */    0x69, 0x0A, 0xE6, 0x61, 0xD0, 0x67, 0x08, 0x4F, 
                /* 0458 */    0x25, 0xC8, 0xEB, 0xD3, 0xAB, 0xA0, 0x31, 0x9E, 
                /* 0460 */    0x1B, 0x1E, 0xA8, 0x8E, 0x27, 0x4A, 0x88, 0x50, 
                /* 0468 */    0x91, 0xCE, 0xE0, 0x55, 0x8A, 0x1F, 0xA4, 0xA2, 
                /* 0470 */    0x04, 0x09, 0xF5, 0x1A, 0xF0, 0x34, 0xE8, 0x2B, 
                /* 0478 */    0x44, 0x94, 0xA8, 0x21, 0x23, 0xBE, 0x58, 0xF9, 
                /* 0480 */    0x34, 0xC5, 0x22, 0x9D, 0xA6, 0x00, 0x9A, 0x9C, 
                /* 0488 */    0x18, 0xF0, 0xA7, 0x29, 0x58, 0xB7, 0x04, 0xCF, 
                /* 0490 */    0xEE, 0x11, 0x83, 0x9F, 0xA7, 0xC0, 0xFD, 0xFF, 
                /* 0498 */    0x3F, 0x4F, 0xE1, 0xF2, 0x9C, 0xA7, 0x68, 0x96, 
                /* 04A0 */    0xF3, 0x14, 0xEA, 0x7C, 0xE1, 0x24, 0x4B, 0x15, 
                /* 04A8 */    0xFE, 0x23, 0x85, 0x11, 0x8E, 0x87, 0x13, 0x58, 
                /* 04B0 */    0xFF, 0x89, 0x0A, 0xA5, 0x9C, 0x42, 0xCA, 0xCE, 
                /* 04B8 */    0x41, 0x28, 0x2D, 0xE7, 0x20, 0x0A, 0xE2, 0x73, 
                /* 04C0 */    0x10, 0x9C, 0x13, 0x15, 0x36, 0xD9, 0x89, 0x0A, 
                /* 04C8 */    0xFA, 0x15, 0x07, 0x77, 0x41, 0x86, 0x3D, 0x2F, 
                /* 04D0 */    0xB6, 0xBE, 0x77, 0x2A, 0xC0, 0x92, 0xBC, 0xC9, 
                /* 04D8 */    0xA3, 0x04, 0x4D, 0x9E, 0x82, 0x78, 0xF2, 0xBE, 
                /* 04E0 */    0x0D, 0xF9, 0x4E, 0x05, 0x37, 0xDC, 0x9D, 0x0A, 
                /* 04E8 */    0x14, 0xC3, 0x07, 0xC3, 0xFF, 0x7F, 0xF8, 0xB0, 
                /* 04F0 */    0x6F, 0x55, 0x80, 0x9B, 0xE0, 0xB7, 0x2A, 0x40, 
                /* 04F8 */    0xCF, 0x00, 0x9F, 0x07, 0xC0, 0x72, 0x0D, 0xE1, 
                /* 0500 */    0xD7, 0x2A, 0xDF, 0x08, 0x30, 0x07, 0x82, 0x67, 
                /* 0508 */    0x1E, 0x63, 0x62, 0x2E, 0x33, 0x7A, 0x2B, 0xF8, 
                /* 0510 */    0x0A, 0xE5, 0x25, 0x4A, 0x1E, 0x0C, 0xEA, 0x6E, 
                /* 0518 */    0x05, 0xF6, 0xFF, 0xFF, 0xDD, 0x0A, 0xD8, 0x5E, 
                /* 0520 */    0xB4, 0xC1, 0x73, 0x57, 0x78, 0x14, 0xF2, 0xA1, 
                /* 0528 */    0xC0, 0x37, 0x2B, 0xF8, 0xC3, 0x38, 0x82, 0xC3, 
                /* 0530 */    0x8F, 0xF0, 0xDC, 0x6B, 0x84, 0xE7, 0x2A, 0x5F, 
                /* 0538 */    0x7B, 0xC1, 0x1D, 0xFB, 0x39, 0xA2, 0x43, 0x80, 
                /* 0540 */    0x6F, 0x56, 0x80, 0xE9, 0xFF, 0xFF, 0xCD, 0x0A, 
                /* 0548 */    0xAC, 0x6F, 0x10, 0x9F, 0x6B, 0xE0, 0x06, 0x3E, 
                /* 0550 */    0x97, 0xD0, 0xEB, 0x3F, 0xF0, 0xBC, 0x30, 0x82, 
                /* 0558 */    0xE7, 0x18, 0xE1, 0xDB, 0x28, 0xEE, 0x84, 0x03, 
                /* 0560 */    0x36, 0xA3, 0x27, 0x1C, 0x04, 0x38, 0xFE, 0x66, 
                /* 0568 */    0x06, 0x6B, 0x0C, 0x7D, 0xA2, 0xE8, 0x8C, 0x81, 
                /* 0570 */    0xBB, 0x9A, 0x01, 0x8F, 0x1B, 0x91, 0x87, 0xC0, 
                /* 0578 */    0x4F, 0x13, 0x1E, 0x02, 0x1F, 0x40, 0xAB, 0xD3, 
                /* 0580 */    0x23, 0x67, 0x9F, 0x53, 0xC2, 0x1D, 0x07, 0xF8, 
                /* 0588 */    0x94, 0x70, 0x03, 0xE0, 0xFF, 0x7F, 0x82, 0x01, 
                /* 0590 */    0x6E, 0x9C, 0xA8, 0xE8, 0x37, 0x4E, 0x80, 0x10, 
                /* 0598 */    0x20, 0x11, 0x5E, 0x35, 0x7D, 0x88, 0x79, 0xD0, 
                /* 05A0 */    0xF4, 0x60, 0xDE, 0x62, 0x8C, 0xF3, 0xD6, 0xF0, 
                /* 05A8 */    0xB2, 0xE9, 0x83, 0x8C, 0xF1, 0xC2, 0x44, 0x39, 
                /* 05B0 */    0x86, 0x43, 0x8A, 0x19, 0xC5, 0x88, 0x41, 0x42, 
                /* 05B8 */    0xBC, 0x71, 0x1A, 0xC3, 0xA8, 0xC1, 0xC2, 0x45, 
                /* 05C0 */    0x8F, 0xF0, 0x20, 0xC3, 0xE2, 0xDC, 0x38, 0x01, 
                /* 05C8 */    0x21, 0xFF, 0xFF, 0x83, 0x0C, 0x60, 0xE5, 0x68, 
                /* 05D0 */    0xE6, 0x83, 0x08, 0xFC, 0xE3, 0xC3, 0x9B, 0x42, 
                /* 05D8 */    0xF0, 0xA7, 0x10, 0x60, 0x22, 0xFE, 0xBE, 0x49, 
                /* 05E0 */    0x85, 0xDF, 0x37, 0x51, 0x63, 0xB4, 0xF8, 0x85, 
                /* 05E8 */    0xEA, 0xFA, 0xEC, 0xB9, 0x78, 0xDA, 0x96, 0x7D, 
                /* 05F0 */    0xDB, 0x44, 0x09, 0xA6, 0x90, 0xA8, 0x13, 0x22, 
                /* 05F8 */    0x4A, 0xC6, 0x09, 0x91, 0x82, 0x18, 0xD0, 0x19, 
                /* 0600 */    0x6F, 0x9B, 0x90, 0x43, 0xDD, 0x36, 0xA1, 0xDF, 
                /* 0608 */    0x1E, 0x9E, 0xE1, 0xC1, 0x79, 0xD6, 0x04, 0xDB, 
                /* 0610 */    0xFF, 0xFF, 0xAC, 0x09, 0x4C, 0xA5, 0x0D, 0x1D, 
                /* 0618 */    0x25, 0x66, 0xE8, 0x14, 0xC4, 0xF7, 0x56, 0x38, 
                /* 0620 */    0x87, 0x28, 0x7C, 0xB0, 0xB3, 0x26, 0x28, 0x4E, 
                /* 0628 */    0x4C, 0xE0, 0x99, 0x3B, 0xF6, 0xA4, 0x09, 0xD8, 
                /* 0630 */    0x89, 0x7C, 0xD2, 0x04, 0x82, 0xFF, 0xFF, 0xE3, 
                /* 0638 */    0x18, 0xD8, 0x8F, 0x54, 0xB8, 0xD3, 0x00, 0xDC, 
                /* 0640 */    0x03, 0x88, 0xC7, 0x70, 0x9C, 0xEF, 0x4F, 0x06, 
                /* 0648 */    0x79, 0x1E, 0xF1, 0x81, 0xC0, 0x47, 0x19, 0xA6, 
                /* 0650 */    0xD0, 0xA6, 0x4F, 0x8D, 0x46, 0xAD, 0x1A, 0x94, 
                /* 0658 */    0xA9, 0x51, 0xA6, 0x41, 0xAD, 0x3E, 0x95, 0x1A, 
                /* 0660 */    0x33, 0x76, 0xC0, 0xB0, 0x88, 0xB5, 0x6A, 0xB0, 
                /* 0668 */    0x0E, 0xB5, 0x5E, 0x81, 0x58, 0xD2, 0x13, 0x43, 
                /* 0670 */    0x20, 0x16, 0xE5, 0x01, 0x84, 0xC5, 0x35, 0x01, 
                /* 0678 */    0xC2, 0x84, 0xAF, 0x4A, 0x20, 0x8E, 0x0D, 0x42, 
                /* 0680 */    0xC5, 0xEA, 0x80, 0x68, 0x64, 0x88, 0x06, 0x11, 
                /* 0688 */    0x90, 0x43, 0xF8, 0x00, 0x62, 0x91, 0x40, 0x04, 
                /* 0690 */    0xE4, 0xC8, 0x4A, 0x40, 0x98, 0x60, 0x27, 0x20, 
                /* 0698 */    0x2C, 0xF3, 0xAB, 0x4A, 0x80, 0x16, 0x60, 0x05, 
                /* 06A0 */    0x88, 0xE9, 0xD1, 0x02, 0xC4, 0xD4, 0x81, 0x08, 
                /* 06A8 */    0xC8, 0x29, 0xCC, 0x80, 0x30, 0x0D, 0xAB, 0x12, 
                /* 06B0 */    0x88, 0xF3, 0x83, 0xD0, 0xD4, 0x76, 0x40, 0x98, 
                /* 06B8 */    0x66, 0x3D, 0x20, 0x2C, 0xA9, 0x1F, 0x70, 0x16, 
                /* 06C0 */    0x1B, 0x44, 0x40, 0x56, 0x60, 0x08, 0x88, 0xE9, 
                /* 06C8 */    0x01, 0x11, 0x90, 0xFF, 0xFF
            })
        }

        Scope (\)
        {
            Method (WMIA, 1, NotSerialized)
            {
                \_SB.AMW0.WMI4 (Arg0)
                Notify (\_SB.AMW0, 0xD0)
            }
        }

        Device (ALS)
        {
            Name (_HID, "ACPI0008")
            Name (DALR, Package (0x10)
            {
                Package (0x02)
                {
                    Zero, 
                    0x05
                }, 

                Package (0x02)
                {
                    Zero, 
                    0x0C
                }, 

                Package (0x02)
                {
                    Zero, 
                    0x14
                }, 

                Package (0x02)
                {
                    Zero, 
                    0x1D
                }, 

                Package (0x02)
                {
                    Zero, 
                    0x27
                }, 

                Package (0x02)
                {
                    Zero, 
                    0x32
                }, 

                Package (0x02)
                {
                    Zero, 
                    0x3E
                }, 

                Package (0x02)
                {
                    Zero, 
                    0x4B
                }, 

                Package (0x02)
                {
                    Zero, 
                    0x59
                }, 

                Package (0x02)
                {
                    Zero, 
                    0x68
                }, 

                Package (0x02)
                {
                    Zero, 
                    0x78
                }, 

                Package (0x02)
                {
                    Zero, 
                    0x89
                }, 

                Package (0x02)
                {
                    Zero, 
                    0x9D
                }, 

                Package (0x02)
                {
                    Zero, 
                    0xBB
                }, 

                Package (0x02)
                {
                    Zero, 
                    0xD9
                }, 

                Package (0x02)
                {
                    Zero, 
                    0xFF
                }
            })
            Method (_STA, 0, NotSerialized)
            {
                If (LEqual (MIS3, 0x80))
                {
                    SX10 ()
                    SX30 (0x1E)
                    SX30 (Zero)
                    SX11 ()
                    Store (SX40 (), Local0)
                    SX12 ()
                    Return (Local0)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_ALI, 0, NotSerialized)
            {
                SX10 ()
                SX30 (0x1E)
                SX30 (One)
                SX11 ()
                Store (SX40 (), Local0)
                SX12 ()
                Return (Local0)
            }

            Method (_ALR, 0, NotSerialized)
            {
                SX10 ()
                SX30 (0x1E)
                SX30 (0x02)
                SX11 ()
                Store (Zero, Local0)
                Store (0x10, Local1)
                While (LLess (Local0, Local1))
                {
                    Store (SX40 (), Index (DerefOf (Index (DALR, Local0)), Zero))
                    Increment (Local0)
                }

                SX12 ()
                Return (DALR)
            }
        }
    }

    Name (_S0, Package (0x03)
    {
        Zero, 
        Zero, 
        Zero
    })
    Name (_S3, Package (0x03)
    {
        0x05, 
        Zero, 
        Zero
    })
    Name (_S4, Package (0x03)
    {
        0x07, 
        Zero, 
        Zero
    })
    Name (_S5, Package (0x03)
    {
        0x07, 
        Zero, 
        Zero
    })
    Mutex (GFXM, 0x01)
    Name (WAKE, Zero)
    Method (NEVT, 0, NotSerialized)
    {
        Store (ECG1 (), Local0)
        If (And (Local0, 0x1000))
        {
            Notify (\_SB.PCI0.PCIE, Zero)
        }

        If (And (Local0, One))
        {
            Notify (\_SB.PBTN, 0x80)
        }

        If (And (Local0, 0x04))
        {
            LIDE ()
        }

        If (And (Local0, 0x08))
        {
            PWRE ()
        }

        If (And (Local0, 0x10))
        {
            DCKE ()
        }

        If (And (Local0, 0x20))
        {
            BAYE ()
        }

        If (And (Local0, 0x40))
        {
            Notify (\_SB.SBTN, 0x80)
        }

        If (And (Local0, 0x80))
        {
            SMIE ()
        }

        If (And (Local0, 0x4000))
        {
            Notify (\_SB.ALS, 0x80)
        }

        If (And (Local0, 0x0800))
        {
            WMIA (0x0800)
        }
    }

    Method (LIDE, 0, NotSerialized)
    {
        SMI (0x43, Zero)
        Notify (\_SB.LID, 0x80)
    }

    Method (QKE, 0, NotSerialized)
    {
        Notify (\_SB.AMW0, 0xD0)
    }

    Method (PWRE, 0, NotSerialized)
    {
        Store (ECG5 (), Local0)
        XOr (Local0, MIS0, Local1)
        And (Local0, 0x13, MIS0)
        If (And (Local1, One))
        {
            Notify (\_SB.AC, 0x80)
        }

        And (MIS0, 0x02, Local2)
        If (And (Local1, 0x02))
        {
            If (Local2)
            {
                Notify (\_SB.BAT0, 0x81)
            }
            Else
            {
                Notify (\_SB.BAT0, 0x81)
            }
        }

        If (And (Local1, 0x04))
        {
            If (Local2)
            {
                Notify (\_SB.BAT0, 0x80)
            }
        }

        If (And (Local1, 0x08))
        {
            If (Local2)
            {
                Notify (\_SB.BAT0, 0x80)
            }
        }

        And (MIS0, 0x10, Local2)
        If (And (Local1, 0x10))
        {
            If (Local2)
            {
                Notify (\_SB.BAT1, 0x81)
            }
            Else
            {
                Notify (\_SB.BAT1, 0x81)
            }
        }

        If (And (Local1, 0x20))
        {
            If (Local2)
            {
                Notify (\_SB.BAT1, 0x80)
            }
        }

        If (And (Local1, 0x40))
        {
            If (Local2)
            {
                Notify (\_SB.BAT1, 0x80)
            }
        }
    }

    Method (DCKE, 0, NotSerialized)
    {
        Store (PNPQ (One), Local0)
        If (LEqual (Local0, Zero))
        {
            Notify (\_SB.PCI0.ISAB.ECP, 0x03)
            Notify (\_SB.PCI0.ISAB.UAR1, 0x03)
        }
        Else
        {
            Notify (\_SB.PCI0.ISAB.ECP, One)
            Notify (\_SB.PCI0.ISAB.UAR1, One)
        }

        Store (ECRB (0x2D), MIS5)
    }

    Method (BAYE, 0, NotSerialized)
    {
        Store (SMI (0x86, Zero), Local0)
        SMI (0x90, One)
        SMI (0xBA, Zero)
    }

    Method (CESM, 1, NotSerialized)
    {
        Store (Arg0, Local0)
        SX10 ()
        SX30 (0x18)
        SX11 ()
        Store (SX42 (), Local0)
        SX12 ()
        If (LGreaterEqual (OSID (), 0x20))
        {
            If (And (Local0, 0x04))
            {
                Notify (\_SB.PCI0.AGP.VID.LCD, 0x86)
            }

            If (And (Local0, 0x02))
            {
                Notify (\_SB.PCI0.AGP.VID.LCD, 0x87)
            }
        }

        If (And (Local0, 0x08))
        {
            Notify (\_SB.ALS, One)
        }
    }

    Method (SMIE, 0, NotSerialized)
    {
        Store (SMI (0x96, Zero), Local0)
        If (And (Local0, One))
        {
            Notify (\_TZ.THM, 0x80)
        }

        If (And (Local0, 0x20))
        {
            Notify (\_SB.PCI0.AGP.VID, 0x81)
        }

        If (And (Local0, 0x02))
        {
            Notify (\_SB.PCI0.AGP.VID, 0x80)
        }

        If (And (Local0, 0x04))
        {
            CESM (Local0)
        }

        If (And (Local0, 0x08))
        {
            Notify (\_PR.CPU0, 0x80)
            Notify (\_PR.CPU1, 0x80)
        }

        If (And (Local0, 0x10))
        {
            Notify (\_SB.PCI0.IDE0.SEC0.MAST, One)
            If (LGreaterEqual (OSID (), 0x10))
            {
                Notify (\_SB.PCI0.IDE0.SEC0, One)
            }
        }
    }

    OperationRegion (PMRS, SystemIO, 0x1030, One)
    Field (PMRS, ByteAcc, NoLock, Preserve)
    {
            ,   4, 
        SLPE,   1
    }

    Method (_PTS, 1, NotSerialized)
    {
        If (LEqual (Arg0, 0x05))
        {
            Store (Zero, SLPE)
            Sleep (0x10)
        }
    }

    Method (_WAK, 1, NotSerialized)
    {
        \_SB.PCI0.ISAB.ECDV.ECIN ()
        SMI (0x9A, Arg0)
        If (And (LEqual (Arg0, 0x03), LGreaterEqual (OSID (), 0x20)))
        {
            Store (SMI (0x68, Zero), Local0)
            If (And (Local0, 0x02))
            {
                BAYE ()
            }
        }
        Else
        {
            BAYE ()
        }

        Store (ECRB (0x2D), Local0)
        If (LNotEqual (Local0, MIS5))
        {
            DCKE ()
        }

        If (LEqual (Arg0, 0x04))
        {
            Notify (\_SB.PBTN, 0x02)
            Store (One, MIS4)
            SOST ()
        }

        Store (ECG5 (), MIS0)
        Notify (\_SB.AC, 0x80)
        \_SB.PCI0.WKHP ()
        Return (Package (0x02)
        {
            Zero, 
            Zero
        })
    }

    Method (DTGP, 5, NotSerialized)
    {
        If (LEqual (Arg0, Buffer (0x10)
                {
                    /* 0000 */    0xC6, 0xB7, 0xB5, 0xA0, 0x18, 0x13, 0x1C, 0x44, 
                    /* 0008 */    0xB0, 0xC9, 0xFE, 0x69, 0x5E, 0xAF, 0x94, 0x9B
                }))
        {
            If (LEqual (Arg1, One))
            {
                If (LEqual (Arg2, Zero))
                {
                    Store (Buffer (One)
                        {
                            0x03
                        }, Arg4)
                    Return (One)
                }

                If (LEqual (Arg2, One))
                {
                    Return (One)
                }
            }
        }

        Store (Buffer (One)
            {
                0x00
            }, Arg4)
        Return (One)
    }

    OperationRegion (GPIO, SystemIO, 0x0500, 0x3C)
    Field (GPIO, ByteAcc, NoLock, Preserve)
    {
        GU00,   8, 
        GU01,   8, 
        GU02,   8, 
        GU03,   8, 
        GIO0,   8, 
        GIO1,   8, 
        GIO2,   8, 
        GIO3,   8, 
                Offset (0x0C), 
        GL00,   8, 
        GL01,   8, 
        GL02,   8, 
        GL03,   8, 
                Offset (0x18), 
        GB00,   8, 
        GB01,   8, 
        GB02,   8, 
        GB03,   8, 
                Offset (0x2C), 
        GIV0,   8, 
        GIV1,   7, 
        GI15,   1, 
        GIV2,   8, 
        GIV3,   8, 
        GU04,   8, 
        GU05,   8, 
        GU06,   8, 
        GU07,   8, 
        GIO4,   8, 
        GIO5,   8, 
        GIO6,   8, 
        GIO7,   8, 
        GL04,   8, 
        GL05,   8, 
        GL06,   8, 
        GL07,   8
    }

    OperationRegion (BSKU, SystemMemory, 0xFFBC0100, One)
    Field (BSKU, ByteAcc, NoLock, Preserve)
    {
            ,   1, 
        BPHP,   3, 
                Offset (0x01)
    }

    OperationRegion (GPE0, SystemIO, 0x042C, 0x04)
    Field (GPE0, ByteAcc, NoLock, Preserve)
    {
            ,   1, 
        GPEH,   1, 
            ,   7, 
        PEEN,   1, 
            ,   1, 
        PMEE,   1, 
                Offset (0x03), 
        PCIX,   1, 
                Offset (0x04)
    }

    Method (NWAK, 0, NotSerialized)
    {
        Store (One, WAKE)
        Store (ECG7 (), Local0)
        Store (Zero, Local1)
        If (LEqual (Local0, Zero))
        {
            Store (One, Local1)
        }

        If (And (Local0, One))
        {
            Store (One, Local1)
        }

        If (And (Local0, 0x02))
        {
            LIDE ()
        }

        If (And (Local0, 0x20))
        {
            If (LEqual (OSID (), 0x02))
            {
                Store (One, Local1)
            }
        }

        Notify (\_SB.BAT0, 0x81)
        Notify (\_SB.BAT1, 0x81)
        If (LEqual (Local0, 0x04))
        {
            Store (One, Local1)
        }

        If (Local1)
        {
            Notify (\_SB.PBTN, 0x02)
        }

        Store (Zero, WAKE)
    }

    Scope (_GPE)
    {
        Method (_L01, 0, NotSerialized)
        {
            \_SB.PCI0.POHP ()
        }

        Method (_L17, 0, NotSerialized)
        {
            NWAK ()
        }

        Method (_L0B, 0, NotSerialized)
        {
            Store (Zero, Local0)
            Notify (\_SB.PCI0, 0x02)
        }

        Method (_L18, 0, NotSerialized)
        {
            Store (Zero, Local0)
        }

        Method (_L03, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB1, 0x02)
        }

        Method (_L04, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB2, 0x02)
        }

        Method (_L0C, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB3, 0x02)
        }

        Method (_L0E, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB4, 0x02)
        }

        Method (_L05, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB5, 0x02)
        }

        Method (_L0D, 0, NotSerialized)
        {
            Store (SMI (0xCF, Zero), Local0)
            If (And (Local0, One))
            {
                Notify (\_SB.PCI0.AZAL, 0x02)
            }

            If (And (Local0, 0x02))
            {
                Notify (\_SB.PCI0.EHCI, 0x02)
            }

            If (And (Local0, 0x04))
            {
                Notify (\_SB.PCI0.EHC2, 0x02)
            }
        }

        Method (_L09, 0, NotSerialized)
        {
            Store (SMI (0xC6, Zero), Local0)
            If (And (Local0, 0x02))
            {
                Notify (\_SB.PCI0.RP02.PXS2, 0x02)
            }

            If (And (Local0, 0x04))
            {
                Notify (\_SB.PCI0.RP04.PXS4, 0x02)
            }
        }
    }

    Scope (_SB.PCI0.ISAB)
    {
        Device (ECDV)
        {
            Name (_HID, EisaId ("PNP0C09"))
            Name (_UID, Zero)
            Name (_CRS, ResourceTemplate ()
            {
                IO (Decode16,
                    0x0930,             // Range Minimum
                    0x0930,             // Range Maximum
                    0x00,               // Alignment
                    0x01,               // Length
                    )
                IO (Decode16,
                    0x0934,             // Range Minimum
                    0x0934,             // Range Maximum
                    0x00,               // Alignment
                    0x01,               // Length
                    )
            })
            Name (_GPE, 0x11)
            OperationRegion (ECOR, EmbeddedControl, Zero, 0xFF)
            Field (ECOR, ByteAcc, Lock, Preserve)
            {
                EC00,   8, 
                EC01,   8, 
                EC02,   8, 
                EC03,   8, 
                EC04,   8, 
                EC05,   8, 
                EC06,   8, 
                EC07,   8, 
                EC08,   8, 
                EC09,   8, 
                EC10,   8, 
                EC11,   8, 
                EC12,   8, 
                EC13,   8, 
                EC14,   8, 
                EC15,   8, 
                EC16,   8, 
                EC17,   8, 
                EC18,   8, 
                EC19,   8, 
                EC20,   8, 
                EC21,   8, 
                EC22,   8, 
                EC23,   8, 
                EC24,   8, 
                EC25,   8, 
                EC26,   8, 
                EC27,   8, 
                EC28,   8, 
                EC29,   8, 
                EC30,   8, 
                EC31,   8, 
                EC32,   8, 
                EC33,   8, 
                EC34,   8, 
                EC35,   8, 
                EC36,   8, 
                EC37,   8, 
                EC38,   8, 
                EC39,   8, 
                EC40,   8, 
                EC41,   8, 
                EC42,   8, 
                EC43,   8, 
                EC44,   8, 
                EC45,   8, 
                EC46,   8, 
                EC47,   8, 
                EC48,   8, 
                EC49,   8
            }

            Method (ECIN, 0, NotSerialized)
            {
                ECS3 ()
                ECS2 (MIS3)
            }

            Method (_REG, 2, NotSerialized)
            {
                If (LAnd (LEqual (Arg0, 0x03), LEqual (Arg1, One)))
                {
                    Store (One, ECRD)
                    ECIN ()
                }
            }

            Method (_Q66, 0, NotSerialized)
            {
                NEVT ()
            }

            Method (ECR1, 1, NotSerialized)
            {
                Acquire (ECMX, 0xFFFF)
                If (LEqual (ECDL (), Zero))
                {
                    SX10 ()
                    SX30 (0x1D)
                    SX30 (0x80)
                    SX30 (Arg0)
                    SX11 ()
                    Store (SX40 (), Local0)
                    SX12 ()
                    Release (ECMX)
                    Return (Local0)
                }

                Store (Zero, Local0)
                If (LEqual (Arg0, Zero))
                {
                    Store (EC00, Local0)
                }

                If (LEqual (Arg0, One))
                {
                    Store (EC01, Local0)
                }

                If (LEqual (Arg0, 0x02))
                {
                    Store (EC02, Local0)
                }

                If (LEqual (Arg0, 0x03))
                {
                    Store (EC03, Local0)
                }

                If (LEqual (Arg0, 0x04))
                {
                    Store (EC04, Local0)
                }

                If (LEqual (Arg0, 0x05))
                {
                    Store (EC05, Local0)
                }

                If (LEqual (Arg0, 0x06))
                {
                    Store (EC06, Local0)
                }

                If (LEqual (Arg0, 0x07))
                {
                    Store (EC07, Local0)
                }

                If (LEqual (Arg0, 0x08))
                {
                    Store (EC08, Local0)
                }

                If (LEqual (Arg0, 0x09))
                {
                    Store (EC09, Local0)
                }

                If (LEqual (Arg0, 0x0A))
                {
                    Store (EC10, Local0)
                }

                If (LEqual (Arg0, 0x0B))
                {
                    Store (EC11, Local0)
                }

                If (LEqual (Arg0, 0x0C))
                {
                    Store (EC12, Local0)
                }

                If (LEqual (Arg0, 0x0D))
                {
                    Store (EC13, Local0)
                }

                If (LEqual (Arg0, 0x0E))
                {
                    Store (EC14, Local0)
                }

                If (LEqual (Arg0, 0x0F))
                {
                    Store (EC15, Local0)
                }

                If (LEqual (Arg0, 0x10))
                {
                    Store (EC16, Local0)
                }

                If (LEqual (Arg0, 0x11))
                {
                    Store (EC17, Local0)
                }

                If (LEqual (Arg0, 0x12))
                {
                    Store (EC18, Local0)
                }

                If (LEqual (Arg0, 0x13))
                {
                    Store (EC19, Local0)
                }

                If (LEqual (Arg0, 0x14))
                {
                    Store (EC20, Local0)
                }

                If (LEqual (Arg0, 0x15))
                {
                    Store (EC21, Local0)
                }

                If (LEqual (Arg0, 0x16))
                {
                    Store (EC22, Local0)
                }

                If (LEqual (Arg0, 0x17))
                {
                    Store (EC23, Local0)
                }

                If (LEqual (Arg0, 0x18))
                {
                    Store (EC24, Local0)
                }

                If (LEqual (Arg0, 0x19))
                {
                    Store (EC25, Local0)
                }

                If (LEqual (Arg0, 0x1A))
                {
                    Store (EC26, Local0)
                }

                If (LEqual (Arg0, 0x1B))
                {
                    Store (EC27, Local0)
                }

                If (LEqual (Arg0, 0x1C))
                {
                    Store (EC28, Local0)
                }

                If (LEqual (Arg0, 0x1D))
                {
                    Store (EC29, Local0)
                }

                If (LEqual (Arg0, 0x1E))
                {
                    Store (EC30, Local0)
                }

                If (LEqual (Arg0, 0x1F))
                {
                    Store (EC31, Local0)
                }

                If (LEqual (Arg0, 0x20))
                {
                    Store (EC32, Local0)
                }

                If (LEqual (Arg0, 0x21))
                {
                    Store (EC33, Local0)
                }

                If (LEqual (Arg0, 0x22))
                {
                    Store (EC34, Local0)
                }

                If (LEqual (Arg0, 0x23))
                {
                    Store (EC35, Local0)
                }

                If (LEqual (Arg0, 0x24))
                {
                    Store (EC36, Local0)
                }

                If (LEqual (Arg0, 0x25))
                {
                    Store (EC37, Local0)
                }

                If (LEqual (Arg0, 0x26))
                {
                    Store (EC38, Local0)
                }

                If (LEqual (Arg0, 0x27))
                {
                    Store (EC39, Local0)
                }

                If (LEqual (Arg0, 0x28))
                {
                    Store (EC40, Local0)
                }

                If (LEqual (Arg0, 0x29))
                {
                    Store (EC41, Local0)
                }

                If (LEqual (Arg0, 0x2A))
                {
                    Store (EC42, Local0)
                }

                If (LEqual (Arg0, 0x2B))
                {
                    Store (EC43, Local0)
                }

                If (LEqual (Arg0, 0x2C))
                {
                    Store (EC44, Local0)
                }

                If (LEqual (Arg0, 0x2D))
                {
                    Store (EC45, Local0)
                }

                If (LEqual (Arg0, 0x2E))
                {
                    Store (EC46, Local0)
                }

                If (LEqual (Arg0, 0x2F))
                {
                    Store (EC47, Local0)
                }

                If (LEqual (Arg0, 0x30))
                {
                    Store (EC48, Local0)
                }

                If (LEqual (Arg0, 0x31))
                {
                    Store (EC49, Local0)
                }

                Release (ECMX)
                Return (Local0)
            }

            Method (ECR2, 1, NotSerialized)
            {
                Store (ECR1 (Arg0), Local0)
                Increment (Arg0)
                ShiftLeft (ECR1 (Arg0), 0x08, Local1)
                Add (Local1, Local0, Local0)
                Return (Local0)
            }

            Method (ECW1, 2, NotSerialized)
            {
                Acquire (ECMX, 0xFFFF)
                If (LEqual (ECDL (), Zero))
                {
                    SX10 ()
                    SX30 (0x1D)
                    SX30 (0x81)
                    SX30 (Arg0)
                    SX30 (Arg1)
                    SX11 ()
                    SX12 ()
                    Release (ECMX)
                    Return (Zero)
                }

                If (LEqual (Arg0, Zero))
                {
                    Store (Arg1, EC00)
                }

                If (LEqual (Arg0, One))
                {
                    Store (Arg1, EC01)
                }

                If (LEqual (Arg0, 0x02))
                {
                    Store (Arg1, EC02)
                }

                If (LEqual (Arg0, 0x03))
                {
                    Store (Arg1, EC03)
                }

                If (LEqual (Arg0, 0x04))
                {
                    Store (Arg1, EC04)
                }

                If (LEqual (Arg0, 0x05))
                {
                    Store (Arg1, EC05)
                }

                If (LEqual (Arg0, 0x06))
                {
                    Store (Arg1, EC06)
                }

                If (LEqual (Arg0, 0x07))
                {
                    Store (Arg1, EC07)
                }

                If (LEqual (Arg0, 0x08))
                {
                    Store (Arg1, EC08)
                }

                If (LEqual (Arg0, 0x09))
                {
                    Store (Arg1, EC09)
                }

                If (LEqual (Arg0, 0x0A))
                {
                    Store (Arg1, EC10)
                }

                If (LEqual (Arg0, 0x0B))
                {
                    Store (Arg1, EC11)
                }

                If (LEqual (Arg0, 0x0C))
                {
                    Store (Arg1, EC12)
                }

                Release (ECMX)
                Return (Zero)
            }
        }
    }

    Scope (\)
    {
        Name (ECRD, Zero)
        Mutex (ECMX, 0x01)
        Method (ECDL, 0, NotSerialized)
        {
            If (LEqual (ECRD, Zero))
            {
                Return (Zero)
            }

            Return (One)
        }

        Method (ECBT, 2, NotSerialized)
        {
            Store (\_SB.PCI0.ISAB.ECDV.ECR1 (Arg0), Local0)
            And (Local0, Arg1, Local0)
            If (Local0)
            {
                Return (One)
            }

            Return (Zero)
        }

        Method (ECB1, 2, NotSerialized)
        {
            Store (ECBT (Arg0, Arg1), Local0)
            If (Local0)
            {
                Return (Zero)
            }

            Return (One)
        }

        Method (ECRB, 1, NotSerialized)
        {
            Return (\_SB.PCI0.ISAB.ECDV.ECR1 (Arg0))
        }

        Method (ECRW, 1, NotSerialized)
        {
            Return (\_SB.PCI0.ISAB.ECDV.ECR2 (Arg0))
        }

        Method (ECWB, 2, NotSerialized)
        {
            \_SB.PCI0.ISAB.ECDV.ECW1 (Arg0, Arg1)
        }

        Method (ECG1, 0, NotSerialized)
        {
            Return (ECRW (0x07))
        }

        Method (ECG2, 0, NotSerialized)
        {
            Return (ECBT (Zero, One))
        }

        Method (ECG3, 0, NotSerialized)
        {
            Return (ECBT (Zero, 0x10))
        }

        Method (ECG4, 0, NotSerialized)
        {
            Return (ECBT (0x05, 0x04))
        }

        Method (ECG5, 0, NotSerialized)
        {
            Return (ECRB (0x06))
        }

        Method (ECG7, 0, NotSerialized)
        {
            Store (ECRB (0x09), Local0)
            SMI (0x89, Local0)
            Return (Local0)
        }

        Mutex (ECM1, 0x01)
        Method (ECG6, 2, NotSerialized)
        {
            Acquire (ECM1, 0xFFFF)
            Store (ECG2 (), Local2)
            ECWB (0x03, Arg0)
            Store (ECRB (0x10), Index (Arg1, Zero))
            Store (ECRW (0x12), Local0)
            If (LEqual (Local0, Zero))
            {
                Increment (Local0)
            }
            Else
            {
                If (LNotEqual (Local2, Zero))
                {
                    If (And (Local0, 0x8000))
                    {
                        Store (Ones, Local0)
                    }
                }
                Else
                {
                    If (And (Local0, 0x8000))
                    {
                        Subtract (Zero, Local0, Local0)
                        And (Local0, 0xFFFF, Local0)
                    }
                    Else
                    {
                        Store (Ones, Local0)
                    }
                }
            }

            Store (Local0, Index (Arg1, One))
            Store (ECRW (0x16), Local0)
            Store (Local0, Index (Arg1, 0x02))
            Store (ECRW (0x14), Local0)
            Store (Local0, Index (Arg1, 0x03))
            Release (ECM1)
        }

        Method (ECG8, 1, NotSerialized)
        {
            ECWB (0x04, Arg0)
            Name (LBUF, Buffer (0x21) {})
            Store (Zero, Local0)
            While (LLess (Local0, 0x20))
            {
                Store (ECRB (0x2A), Local1)
                Store (Local1, Index (LBUF, Local0))
                If (LEqual (Local1, Zero))
                {
                    Break
                }

                Increment (Local0)
            }

            If (LNotEqual (Local1, Zero))
            {
                Store (Zero, Index (LBUF, Local0))
                Increment (Local0)
            }

            Increment (Local0)
            Name (OBUF, Buffer (Local0) {})
            Store (LBUF, OBUF)
            Return (OBUF)
        }

        Name (BS01, Package (0x03)
        {
            One, 
            0xFF, 
            "Unknown"
        })
        Name (BS02, Package (0x0F)
        {
            0x03, 
            0x02, 
            "Sony", 
            0x03, 
            "Sanyo", 
            0x04, 
            "Panasonic", 
            0x07, 
            "SMP", 
            0x08, 
            "Motorola", 
            0x06, 
            "Samsung SDI", 
            0xFF, 
            "Unknown"
        })
        Name (BS03, Package (0x13)
        {
            0x02, 
            One, 
            "PbAc", 
            0x02, 
            "LION", 
            0x03, 
            "NiCd", 
            0x04, 
            "NiMH", 
            0x05, 
            "NiZn", 
            0x06, 
            "RAM", 
            0x07, 
            "ZnAR", 
            0x08, 
            "LiP", 
            0xFF, 
            "Unknown"
        })
        Method (ECU0, 2, NotSerialized)
        {
            Store (One, Local0)
            Store (Zero, Local1)
            While (LNotEqual (Local1, 0xFF))
            {
                Store (DerefOf (Index (Arg0, Local0)), Local1)
                If (LEqual (Arg1, Local1))
                {
                    Increment (Local0)
                    Store (DerefOf (Index (Arg0, Local0)), Local2)
                    Store (TO01 (Local2), Local2)
                    Return (Local2)
                }

                Add (Local0, 0x02, Local0)
            }

            Store (DerefOf (Index (Arg0, Zero)), Local2)
            Store (ECG8 (Local2), Local2)
            Return (Local2)
        }

        Method (ECG9, 2, NotSerialized)
        {
            Acquire (ECM1, 0xFFFF)
            ECWB (0x03, Arg0)
            Store (One, Index (Arg1, Zero))
            Store (ECRW (0x20), Local0)
            Store (Local0, Index (Arg1, One))
            Store (ECRW (0x1E), Local1)
            Store (Local1, Index (Arg1, 0x02))
            Store (One, Index (Arg1, 0x03))
            Store (ECRW (0x22), Local2)
            Store (Local2, Index (Arg1, 0x04))
            Divide (Local0, 0x0A, Local5, Local3)
            Store (Local3, Index (Arg1, 0x05))
            Divide (Local0, 0x21, Local5, Local3)
            Store (Local3, Index (Arg1, 0x06))
            Divide (Local0, 0x64, Local5, Local3)
            Store (Local3, Index (Arg1, 0x07))
            Store (Local3, Index (Arg1, 0x08))
            Store (ECU0 (BS01, Zero), Local3)
            Store (Local3, Index (Arg1, 0x09))
            Store (ECRW (0x26), Local3)
            Store (TO03 (Local3), Local3)
            Store (Local3, Index (Arg1, 0x0A))
            Store (ECRB (0x29), Local3)
            Store (ECU0 (BS03, Local3), Local3)
            Store (Local3, Index (Arg1, 0x0B))
            Store (ECRB (0x28), Local3)
            Store (ECU0 (BS02, Local3), Local3)
            Store (Local3, Index (Arg1, 0x0C))
            Release (ECM1)
        }

        Method (ECS1, 1, NotSerialized)
        {
            ECWB (0x02, Arg0)
            SMI (0x8A, Arg0)
        }

        Method (ECS2, 1, NotSerialized)
        {
            ECWB (One, Arg0)
        }

        Method (ECS3, 0, NotSerialized)
        {
            ECWB (0x05, One)
        }

        Mutex (WMEV, 0x01)
        Method (EC0A, 1, NotSerialized)
        {
            Acquire (WMEV, 0xFFFF)
            Store (ECRB (0x2B), Local1)
            Store (Zero, Local0)
            While (LLess (Local0, Local1))
            {
                Store (ECRB (0x2C), Local2)
                If (LLess (Local0, SizeOf (Arg0)))
                {
                    TO04 (Arg0, Local0, Local2)
                }

                Increment (Local0)
            }

            Release (WMEV)
            Return (Arg0)
        }
    }

    Scope (_PR)
    {
        Processor (CPU0, 0x00, 0x00001010, 0x06) {}
        Processor (CPU1, 0x01, 0x00001010, 0x06) {}
        Processor (CPU2, 0x02, 0x00001010, 0x06) {}
        Processor (CPU3, 0x03, 0x00001010, 0x06) {}
    }

    Scope (_TZ)
    {
        ThermalZone (THM)
        {
            Method (_CRT, 0, NotSerialized)
            {
                Store (0x6B, Local0)
                Multiply (Local0, 0x0A, Local0)
                Add (Local0, 0x0AAC, Local0)
                Return (Local0)
            }

            Method (_TMP, 0, NotSerialized)
            {
                Store (GINF (0x04), Local0)
                Return (Local0)
            }

            Method (GINF, 1, NotSerialized)
            {
                SX10 ()
                SX30 (Arg0)
                SX11 ()
                Store (SX41 (), Local0)
                SX12 ()
                If (LLess (Local0, 0x0BA6))
                {
                    Store (0x0BA6, Local0)
                }

                Return (Local0)
            }
        }
    }

    Scope (_PR.CPU1)
    {
        Method (_CST, 0, NotSerialized)
        {
            Return (^^CPU0._CST ())
        }
    }

    Scope (_PR.CPU2)
    {
        Method (_CST, 0, NotSerialized)
        {
            Return (^^CPU0._CST ())
        }
    }

    Scope (_PR.CPU3)
    {
        Method (_CST, 0, NotSerialized)
        {
            Return (^^CPU0._CST ())
        }
    }

    Scope (_PR.CPU1)
    {
        Method (_PPC, 0, NotSerialized)
        {
            Return (^^CPU0._PPC ())
        }

        Method (_PCT, 0, NotSerialized)
        {
            Return (Package (0x02)
            {
                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }
            })
        }

        Method (_PSS, 0, NotSerialized)
        {
            Return (^^CPU0._PSS)
        }

        Method (_PSD, 0, NotSerialized)
        {
            If (And (CFGD, 0x00800000))
            {
                If (And (PDC0, 0x0800))
                {
                    Return (Package (0x01)
                    {
                        Package (0x05)
                        {
                            0x05, 
                            Zero, 
                            Zero, 
                            0xFE, 
                            0x04
                        }
                    })
                }

                Return (Package (0x01)
                {
                    Package (0x05)
                    {
                        0x05, 
                        Zero, 
                        Zero, 
                        0xFC, 
                        0x04
                    }
                })
            }
            Else
            {
                If (And (PDC0, 0x0800))
                {
                    Return (Package (0x01)
                    {
                        Package (0x05)
                        {
                            0x05, 
                            Zero, 
                            Zero, 
                            0xFE, 
                            0x02
                        }
                    })
                }

                Return (Package (0x01)
                {
                    Package (0x05)
                    {
                        0x05, 
                        Zero, 
                        Zero, 
                        0xFC, 
                        0x02
                    }
                })
            }
        }
    }

    Scope (_PR.CPU2)
    {
        Method (_PPC, 0, NotSerialized)
        {
            Return (^^CPU1._PPC ())
        }

        Method (_PCT, 0, NotSerialized)
        {
            Return (^^CPU1._PCT ())
        }

        Method (_PSS, 0, NotSerialized)
        {
            Return (^^CPU1._PSS ())
        }

        Method (_PSD, 0, NotSerialized)
        {
            Return (^^CPU1._PSD ())
        }
    }

    Scope (_PR.CPU3)
    {
        Method (_PPC, 0, NotSerialized)
        {
            Return (^^CPU1._PPC ())
        }

        Method (_PCT, 0, NotSerialized)
        {
            Return (^^CPU1._PCT ())
        }

        Method (_PSS, 0, NotSerialized)
        {
            Return (^^CPU1._PSS ())
        }

        Method (_PSD, 0, NotSerialized)
        {
            Return (^^CPU1._PSD ())
        }
    }

    Scope (_PR.CPU0)
    {
        Method (_CST, 0, NotSerialized)
        {
            If (LAnd (And (CFGD, 0x01000000), LNot (And (PDC0, 0x10
                ))))
            {
                Return (Package (0x02)
                {
                    One, 
                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        One, 
                        0x9D, 
                        0x03E8
                    }
                })
            }

            If (LAnd (And (CFGD, 0x00200000), And (PDC0, 0x0200)))
            {
                If (And (CFGD, 0x0200))
                {
                    Return (Package (0x04)
                    {
                        0x03, 
                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (FFixedHW, 
                                    0x01,               // Bit Width
                                    0x02,               // Bit Offset
                                    0x0000000000000000, // Address
                                    0x01,               // Access Size
                                    )
                            }, 

                            One, 
                            One, 
                            0x03E8
                        }, 

                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (FFixedHW, 
                                    0x01,               // Bit Width
                                    0x02,               // Bit Offset
                                    0x0000000000000010, // Address
                                    0x01,               // Access Size
                                    )
                            }, 

                            0x02, 
                            One, 
                            0x01F4
                        }, 

                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (FFixedHW, 
                                    0x01,               // Bit Width
                                    0x02,               // Bit Offset
                                    0x0000000000000050, // Address
                                    0x03,               // Access Size
                                    )
                            }, 

                            0x03, 
                            0xA2, 
                            0x64
                        }
                    })
                }

                If (And (CFGD, 0x80))
                {
                    Return (Package (0x04)
                    {
                        0x03, 
                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (FFixedHW, 
                                    0x01,               // Bit Width
                                    0x02,               // Bit Offset
                                    0x0000000000000000, // Address
                                    0x01,               // Access Size
                                    )
                            }, 

                            One, 
                            One, 
                            0x03E8
                        }, 

                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (FFixedHW, 
                                    0x01,               // Bit Width
                                    0x02,               // Bit Offset
                                    0x0000000000000010, // Address
                                    0x01,               // Access Size
                                    )
                            }, 

                            0x02, 
                            One, 
                            0x01F4
                        }, 

                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (FFixedHW, 
                                    0x01,               // Bit Width
                                    0x02,               // Bit Offset
                                    0x0000000000000030, // Address
                                    0x03,               // Access Size
                                    )
                            }, 

                            0x03, 
                            0x39, 
                            0x64
                        }
                    })
                }

                If (And (CFGD, 0x40))
                {
                    Return (Package (0x03)
                    {
                        0x02, 
                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (FFixedHW, 
                                    0x01,               // Bit Width
                                    0x02,               // Bit Offset
                                    0x0000000000000000, // Address
                                    0x01,               // Access Size
                                    )
                            }, 

                            One, 
                            One, 
                            0x03E8
                        }, 

                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (FFixedHW, 
                                    0x01,               // Bit Width
                                    0x02,               // Bit Offset
                                    0x0000000000000020, // Address
                                    0x03,               // Access Size
                                    )
                            }, 

                            0x02, 
                            0x11, 
                            0xFA
                        }
                    })
                }

                If (And (CFGD, 0x20))
                {
                    Return (Package (0x03)
                    {
                        0x02, 
                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (FFixedHW, 
                                    0x01,               // Bit Width
                                    0x02,               // Bit Offset
                                    0x0000000000000000, // Address
                                    0x01,               // Access Size
                                    )
                            }, 

                            One, 
                            One, 
                            0x03E8
                        }, 

                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (FFixedHW, 
                                    0x01,               // Bit Width
                                    0x02,               // Bit Offset
                                    0x0000000000000010, // Address
                                    0x01,               // Access Size
                                    )
                            }, 

                            0x02, 
                            One, 
                            0x01F4
                        }
                    })
                }

                Return (Package (0x02)
                {
                    One, 
                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x01,               // Bit Width
                                0x02,               // Bit Offset
                                0x0000000000000000, // Address
                                0x01,               // Access Size
                                )
                        }, 

                        One, 
                        One, 
                        0x03E8
                    }
                })
            }

            If (LAnd (And (CFGD, 0x00200000), And (PDC0, 0x0100)))
            {
                If (And (CFGD, 0x0200))
                {
                    Return (Package (0x04)
                    {
                        0x03, 
                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (FFixedHW, 
                                    0x01,               // Bit Width
                                    0x02,               // Bit Offset
                                    0x0000000000000000, // Address
                                    0x01,               // Access Size
                                    )
                            }, 

                            One, 
                            One, 
                            0x03E8
                        }, 

                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (SystemIO, 
                                    0x08,               // Bit Width
                                    0x00,               // Bit Offset
                                    0x0000000000001014, // Address
                                    ,)
                            }, 

                            0x02, 
                            One, 
                            0x01F4
                        }, 

                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (SystemIO, 
                                    0x08,               // Bit Width
                                    0x00,               // Bit Offset
                                    0x0000000000001018, // Address
                                    ,)
                            }, 

                            0x03, 
                            0xA2, 
                            0x64
                        }
                    })
                }

                If (And (CFGD, 0x80))
                {
                    Return (Package (0x04)
                    {
                        0x03, 
                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (FFixedHW, 
                                    0x01,               // Bit Width
                                    0x02,               // Bit Offset
                                    0x0000000000000000, // Address
                                    0x01,               // Access Size
                                    )
                            }, 

                            One, 
                            One, 
                            0x03E8
                        }, 

                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (SystemIO, 
                                    0x08,               // Bit Width
                                    0x00,               // Bit Offset
                                    0x0000000000001014, // Address
                                    ,)
                            }, 

                            0x02, 
                            One, 
                            0x01F4
                        }, 

                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (SystemIO, 
                                    0x08,               // Bit Width
                                    0x00,               // Bit Offset
                                    0x0000000000001016, // Address
                                    ,)
                            }, 

                            0x03, 
                            0x39, 
                            0x64
                        }
                    })
                }

                If (And (CFGD, 0x40))
                {
                    Return (Package (0x04)
                    {
                        0x03, 
                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (FFixedHW, 
                                    0x01,               // Bit Width
                                    0x02,               // Bit Offset
                                    0x0000000000000000, // Address
                                    0x01,               // Access Size
                                    )
                            }, 

                            One, 
                            One, 
                            0x03E8
                        }, 

                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (SystemIO, 
                                    0x08,               // Bit Width
                                    0x00,               // Bit Offset
                                    0x0000000000001014, // Address
                                    ,)
                            }, 

                            0x02, 
                            One, 
                            0x01F4
                        }, 

                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (SystemIO, 
                                    0x08,               // Bit Width
                                    0x00,               // Bit Offset
                                    0x0000000000001015, // Address
                                    ,)
                            }, 

                            0x03, 
                            0x11, 
                            0xFA
                        }
                    })
                }

                If (And (CFGD, 0x20))
                {
                    Return (Package (0x03)
                    {
                        0x02, 
                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (FFixedHW, 
                                    0x01,               // Bit Width
                                    0x02,               // Bit Offset
                                    0x0000000000000000, // Address
                                    0x01,               // Access Size
                                    )
                            }, 

                            One, 
                            One, 
                            0x03E8
                        }, 

                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (SystemIO, 
                                    0x08,               // Bit Width
                                    0x00,               // Bit Offset
                                    0x0000000000001014, // Address
                                    ,)
                            }, 

                            0x02, 
                            One, 
                            0x01F4
                        }
                    })
                }

                Return (Package (0x02)
                {
                    One, 
                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x01,               // Bit Width
                                0x02,               // Bit Offset
                                0x0000000000000000, // Address
                                0x01,               // Access Size
                                )
                        }, 

                        One, 
                        One, 
                        0x03E8
                    }
                })
            }

            If (And (CFGD, 0x0200))
            {
                Return (Package (0x04)
                {
                    0x03, 
                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        One, 
                        One, 
                        0x03E8
                    }, 

                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (SystemIO, 
                                0x08,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000001014, // Address
                                ,)
                        }, 

                        0x02, 
                        One, 
                        0x01F4
                    }, 

                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (SystemIO, 
                                0x08,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000001018, // Address
                                ,)
                        }, 

                        0x03, 
                        0xA2, 
                        0x64
                    }
                })
            }

            If (And (CFGD, 0x80))
            {
                Return (Package (0x04)
                {
                    0x03, 
                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        One, 
                        One, 
                        0x03E8
                    }, 

                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (SystemIO, 
                                0x08,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000001014, // Address
                                ,)
                        }, 

                        0x02, 
                        One, 
                        0x01F4
                    }, 

                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (SystemIO, 
                                0x08,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000001016, // Address
                                ,)
                        }, 

                        0x03, 
                        0x39, 
                        0x64
                    }
                })
            }

            If (And (CFGD, 0x40))
            {
                Return (Package (0x04)
                {
                    0x03, 
                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        One, 
                        One, 
                        0x03E8
                    }, 

                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (SystemIO, 
                                0x08,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000001014, // Address
                                ,)
                        }, 

                        0x02, 
                        One, 
                        0x01F4
                    }, 

                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (SystemIO, 
                                0x08,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000001015, // Address
                                ,)
                        }, 

                        0x03, 
                        0x11, 
                        0xFA
                    }
                })
            }

            If (And (CFGD, 0x20))
            {
                Return (Package (0x03)
                {
                    0x02, 
                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        One, 
                        One, 
                        0x03E8
                    }, 

                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (SystemIO, 
                                0x08,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000001014, // Address
                                ,)
                        }, 

                        0x02, 
                        One, 
                        0x01F4
                    }
                })
            }

            Return (Package (0x02)
            {
                One, 
                Package (0x04)
                {
                    ResourceTemplate ()
                    {
                        Register (FFixedHW, 
                            0x00,               // Bit Width
                            0x00,               // Bit Offset
                            0x0000000000000000, // Address
                            ,)
                    }, 

                    One, 
                    One, 
                    0x03E8
                }
            })
        }
    }

    Scope (_PR.CPU0)
    {
        Method (_PPC, 0, NotSerialized)
        {
            Store (SMI (0xAD, Zero), Local0)
            Return (Local0)
        }

        Method (_PCT, 0, NotSerialized)
        {
            If (LAnd (And (CFGD, One), And (PDC0, One)))
            {
                Return (Package (0x02)
                {
                    ResourceTemplate ()
                    {
                        Register (FFixedHW, 
                            0x00,               // Bit Width
                            0x00,               // Bit Offset
                            0x0000000000000000, // Address
                            ,)
                    }, 

                    ResourceTemplate ()
                    {
                        Register (FFixedHW, 
                            0x00,               // Bit Width
                            0x00,               // Bit Offset
                            0x0000000000000000, // Address
                            ,)
                    }
                })
            }

            Return (Package (0x02)
            {
                ResourceTemplate ()
                {
                    Register (SystemIO, 
                        0x10,               // Bit Width
                        0x00,               // Bit Offset
                        0x00000000000000B2, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemIO, 
                        0x08,               // Bit Width
                        0x00,               // Bit Offset
                        0x00000000000000B3, // Address
                        ,)
                }
            })
        }

        Method (XPSS, 0, NotSerialized)
        {
            If (And (PDC0, One))
            {
                Return (NPSS)
            }

            Return (SPSS)
        }

        Name (SPSS, Package (0x05)
        {
            Package (0x06)
            {
                0x0B76, 
                0x88B8, 
                0x6E, 
                0x0A, 
                0x83, 
                Zero
            }, 

            Package (0x06)
            {
                0x4D16, 
                0x88B8, 
                0x6E, 
                0x0A, 
                0x0183, 
                One
            }, 

            Package (0x06)
            {
                0x0856, 
                0x40DF, 
                0x6E, 
                0x0A, 
                0x0283, 
                0x02
            }, 

            Package (0x06)
            {
                0x0640, 
                0x3A98, 
                0x6E, 
                0x0A, 
                0x0383, 
                0x03
            }, 

            Package (0x06)
            {
                0x0640, 
                0x2EE0, 
                0x6E, 
                0x0A, 
                0x0483, 
                0x04
            }
        })
        Name (_PSS, Package (0x05)
        {
            Package (0x06)
            {
                0x0AF1, 
                0x88B8, 
                0x0A, 
                0x0A, 
                0x0B20, 
                0x0B20
            }, 

            Package (0x06)
            {
                0x0AF0, 
                0x88B8, 
                0x0A, 
                0x0A, 
                0x4A1C, 
                0x4A1C
            }, 

            Package (0x06)
            {
                0x0856, 
                0x40DF, 
                0x0A, 
                0x0A, 
                0x0811, 
                0x0811
            }, 

            Package (0x06)
            {
                0x0640, 
                0x3A98, 
                0x0A, 
                0x0A, 
                0x0611, 
                0x0611
            }, 

            Package (0x06)
            {
                0x0320, 
                0x2EE0, 
                0x0A, 
                0x0A, 
                0x8611, 
                0x8611
            }
        })
        Method (_PSD, 0, NotSerialized)
        {
            If (And (CFGD, 0x01000000))
            {
                If (And (CFGD, 0x00800000))
                {
                    If (And (PDC0, 0x0800))
                    {
                        Return (Package (0x01)
                        {
                            Package (0x05)
                            {
                                0x05, 
                                Zero, 
                                Zero, 
                                0xFE, 
                                0x04
                            }
                        })
                    }

                    Return (Package (0x01)
                    {
                        Package (0x05)
                        {
                            0x05, 
                            Zero, 
                            Zero, 
                            0xFC, 
                            0x04
                        }
                    })
                }
                Else
                {
                    If (And (PDC0, 0x0800))
                    {
                        Return (Package (0x01)
                        {
                            Package (0x05)
                            {
                                0x05, 
                                Zero, 
                                Zero, 
                                0xFE, 
                                0x02
                            }
                        })
                    }

                    Return (Package (0x01)
                    {
                        Package (0x05)
                        {
                            0x05, 
                            Zero, 
                            Zero, 
                            0xFC, 
                            0x02
                        }
                    })
                }
            }

            Return (Package (0x01)
            {
                Package (0x05)
                {
                    0x05, 
                    Zero, 
                    Zero, 
                    0xFC, 
                    One
                }
            })
        }
    }

    Scope (\)
    {
        Name (SSDT, Package (0x0C)
        {
            "BspIst  ", 
            0xDF453157, 
            0x02C3, 
            "ApIst   ", 
            0xDF45341A, 
            0x01D7, 
            "BspCst  ", 
            0xDF4535F1, 
            0x05C6, 
            "ApCst   ", 
            0xDF453BB7, 
            0x8D
        })
        Name (CFGD, 0x0B336BF1)
        Name (PDC0, 0x80000000)
        Name (PDC1, 0x80000000)
        Name (PDC2, 0x80000000)
        Name (PDC3, 0x80000000)
        Name (SDTL, Zero)
    }

    Scope (_PR.CPU0)
    {
        Name (HI0, Zero)
        Name (HC0, Zero)
        Method (_PDC, 1, NotSerialized)
        {
            Store (CPDC (Arg0), Local0)
            GCAP (Local0)
            Return (Local0)
        }

        Method (_OSC, 4, NotSerialized)
        {
            Store (COSC (Arg0, Arg1, Arg2, Arg3), Local0)
            GCAP (Local0)
            Return (Local0)
        }

        Method (CPDC, 1, NotSerialized)
        {
            CreateDWordField (Arg0, Zero, REVS)
            CreateDWordField (Arg0, 0x04, SIZE)
            Store (SizeOf (Arg0), Local0)
            Store (Subtract (Local0, 0x08), Local1)
            CreateField (Arg0, 0x40, Multiply (Local1, 0x08), TEMP)
            Name (STS0, Buffer (0x04)
            {
                0x00, 0x00, 0x00, 0x00
            })
            Concatenate (STS0, TEMP, Local2)
            Return (COSC (Buffer (0x10)
                {
                    /* 0000 */    0x16, 0xA6, 0x77, 0x40, 0x0C, 0x29, 0xBE, 0x47, 
                    /* 0008 */    0x9E, 0xBD, 0xD8, 0x70, 0x58, 0x71, 0x39, 0x53
                }, REVS, SIZE, Local2))
        }

        Method (COSC, 4, NotSerialized)
        {
            CreateDWordField (Arg3, Zero, STS0)
            CreateDWordField (Arg3, 0x04, CAP0)
            CreateDWordField (Arg0, Zero, IID0)
            CreateDWordField (Arg0, 0x04, IID1)
            CreateDWordField (Arg0, 0x08, IID2)
            CreateDWordField (Arg0, 0x0C, IID3)
            Name (UID0, Buffer (0x10)
            {
                /* 0000 */    0x16, 0xA6, 0x77, 0x40, 0x0C, 0x29, 0xBE, 0x47, 
                /* 0008 */    0x9E, 0xBD, 0xD8, 0x70, 0x58, 0x71, 0x39, 0x53
            })
            CreateDWordField (UID0, Zero, EID0)
            CreateDWordField (UID0, 0x04, EID1)
            CreateDWordField (UID0, 0x08, EID2)
            CreateDWordField (UID0, 0x0C, EID3)
            If (LNot (LAnd (LAnd (LEqual (IID0, EID0), LEqual (IID1, EID1)), 
                LAnd (LEqual (IID2, EID2), LEqual (IID3, EID3)))))
            {
                Store (0x06, STS0)
                Return (Arg3)
            }

            If (LNotEqual (Arg1, One))
            {
                Store (0x0A, STS0)
                Return (Arg3)
            }

            Return (Arg3)
        }

        Method (GCAP, 1, NotSerialized)
        {
            CreateDWordField (Arg0, Zero, STS0)
            CreateDWordField (Arg0, 0x04, CAP0)
            If (LOr (LEqual (STS0, 0x06), LEqual (STS0, 0x0A)))
            {
                Return (Zero)
            }

            If (And (STS0, One))
            {
                And (CAP0, 0x0BFF, CAP0)
                Return (Zero)
            }

            Or (And (PDC0, 0x7FFFFFFF), CAP0, PDC0)
            If (And (CFGD, One))
            {
                If (LAnd (LAnd (And (CFGD, 0x01000000), LEqual (And (PDC0, 
                    0x09), 0x09)), LNot (And (SDTL, One))))
                {
                    Or (SDTL, One, SDTL)
                    OperationRegion (IST0, SystemMemory, DerefOf (Index (SSDT, One)), DerefOf (Index (SSDT, 0x02
                        )))
                    Load (IST0, HI0)
                }
            }

            If (And (CFGD, 0xF0))
            {
                If (LAnd (LAnd (And (CFGD, 0x01000000), And (PDC0, 0x18
                    )), LNot (And (SDTL, 0x02))))
                {
                    Or (SDTL, 0x02, SDTL)
                    OperationRegion (CST0, SystemMemory, DerefOf (Index (SSDT, 0x07)), DerefOf (Index (SSDT, 0x08
                        )))
                    Load (CST0, HC0)
                }
            }

            Return (Zero)
        }
    }

    Scope (_PR.CPU1)
    {
        Name (HI1, Zero)
        Name (HC1, Zero)
        Method (_PDC, 1, NotSerialized)
        {
            Store (^^CPU0.CPDC (Arg0), Local0)
            GCAP (Local0)
            Return (Local0)
        }

        Method (_OSC, 4, NotSerialized)
        {
            Store (^^CPU0.COSC (Arg0, Arg1, Arg2, Arg3), Local0)
            GCAP (Local0)
            Return (Local0)
        }

        Method (GCAP, 1, NotSerialized)
        {
            CreateDWordField (Arg0, Zero, STS1)
            CreateDWordField (Arg0, 0x04, CAP1)
            If (LOr (LEqual (STS1, 0x06), LEqual (STS1, 0x0A)))
            {
                Return (Zero)
            }

            If (And (STS1, One))
            {
                And (CAP1, 0x0BFF, CAP1)
                Return (Zero)
            }

            Or (And (PDC1, 0x7FFFFFFF), CAP1, PDC1)
            If (LEqual (And (PDC0, 0x09), 0x09))
            {
                APPT ()
            }

            If (And (PDC0, 0x18))
            {
                APCT ()
            }

            Return (Zero)
        }

        Method (APCT, 0, NotSerialized)
        {
            If (LAnd (And (CFGD, 0xF0), LNot (And (SDTL, 0x20
                ))))
            {
                Or (SDTL, 0x20, SDTL)
                OperationRegion (CST1, SystemMemory, DerefOf (Index (SSDT, 0x0A)), DerefOf (Index (SSDT, 0x0B
                    )))
                Load (CST1, HC1)
            }
        }

        Method (APPT, 0, NotSerialized)
        {
            If (LAnd (And (CFGD, One), LNot (And (SDTL, 0x10
                ))))
            {
                Or (SDTL, 0x10, SDTL)
                OperationRegion (IST1, SystemMemory, DerefOf (Index (SSDT, 0x04)), DerefOf (Index (SSDT, 0x05
                    )))
                Load (IST1, HI1)
            }
        }
    }

    Scope (_PR.CPU2)
    {
        Method (_PDC, 1, NotSerialized)
        {
            Store (^^CPU0.CPDC (Arg0), Local0)
            GCAP (Local0)
            Return (Local0)
        }

        Method (_OSC, 4, NotSerialized)
        {
            Store (^^CPU0.COSC (Arg0, Arg1, Arg2, Arg3), Local0)
            GCAP (Local0)
            Return (Local0)
        }

        Method (GCAP, 1, NotSerialized)
        {
            CreateDWordField (Arg0, Zero, STS2)
            CreateDWordField (Arg0, 0x04, CAP2)
            If (LOr (LEqual (STS2, 0x06), LEqual (STS2, 0x0A)))
            {
                Return (Zero)
            }

            If (And (STS2, One))
            {
                And (CAP2, 0x0BFF, CAP2)
                Return (Zero)
            }

            Or (And (PDC2, 0x7FFFFFFF), CAP2, PDC2)
            If (LEqual (And (PDC2, 0x09), 0x09))
            {
                ^^CPU1.APPT ()
            }

            If (And (PDC2, 0x18))
            {
                ^^CPU1.APCT ()
            }

            Return (Zero)
        }
    }

    Scope (_PR.CPU3)
    {
        Method (_PDC, 1, NotSerialized)
        {
            Store (^^CPU0.CPDC (Arg0), Local0)
            GCAP (Local0)
            Return (Local0)
        }

        Method (_OSC, 4, NotSerialized)
        {
            Store (^^CPU0.COSC (Arg0, Arg1, Arg2, Arg3), Local0)
            GCAP (Local0)
            Return (Local0)
        }

        Method (GCAP, 1, NotSerialized)
        {
            CreateDWordField (Arg0, Zero, STS3)
            CreateDWordField (Arg0, 0x04, CAP3)
            If (LOr (LEqual (STS3, 0x06), LEqual (STS3, 0x0A)))
            {
                Return (Zero)
            }

            If (And (STS3, One))
            {
                And (CAP3, 0x0BFF, CAP3)
                Return (Zero)
            }

            Or (And (PDC3, 0x7FFFFFFF), CAP3, PDC3)
            If (LEqual (And (PDC2, 0x09), 0x09))
            {
                ^^CPU1.APPT ()
            }

            If (And (PDC2, 0x18))
            {
                ^^CPU1.APCT ()
            }

            Return (Zero)
        }
    }
}

