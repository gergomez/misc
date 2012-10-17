DefinitionBlock ("dsdt.aml", "DSDT", 1, "LENOVO", "TP-8B   ", 0x00001340)
{
    External (PDC7)
    External (PDC6)
    External (PDC5)
    External (PDC4)
    External (PDC3)
    External (PDC2)
    External (PDC1)
    External (PDC0)
    External (\_SB_.PCI0.SAT1.PRT1)
    External (\_SB_.PCI0.SAT1.SCND.MSTR)
    External (\_SB_.PCI0.SAT1.SCND.GTME)
    External (\_SB_.PCI0.SAT1.PRIM.GTME)
    Scope (\_PR)
    {
        Processor (CPU0, 0x01, 0x00000410, 0x06)
        {
        }
        Processor (CPU1, 0x02, 0x00000410, 0x06)
        {
        }
        Processor (CPU2, 0x03, 0x00000410, 0x06)
        {
        }
        Processor (CPU3, 0x04, 0x00000410, 0x06)
        {
        }
        Processor (CPU4, 0x05, 0x00000410, 0x06)
        {
        }
        Processor (CPU5, 0x06, 0x00000410, 0x06)
        {
        }
        Processor (CPU6, 0x07, 0x00000410, 0x06)
        {
        }
        Processor (CPU7, 0x08, 0x00000410, 0x06)
        {
        }
    }
    Scope (\)
    {
        Method (PNTF, 1, NotSerialized)
        {
            If (And (\PPMF, 0x0400))
            {
                If (LOr (LAnd (And (PDC0, 0x08), LOr (LEqual (Arg0, 
                    0x80), LEqual (Arg0, 0x82))), LAnd (And (PDC0, 0x10), LEqual (Arg0, 
                    0x81))))
                {
                    Notify (\_PR.CPU0, Arg0)
                }
                If (LOr (LAnd (And (PDC1, 0x08), LOr (LEqual (Arg0, 
                    0x80), LEqual (Arg0, 0x82))), LAnd (And (PDC1, 0x10), LEqual (Arg0, 
                    0x81))))
                {
                    Notify (\_PR.CPU1, Arg0)
                }
                If (LOr (LAnd (And (PDC2, 0x08), LOr (LEqual (Arg0, 
                    0x80), LEqual (Arg0, 0x82))), LAnd (And (PDC2, 0x10), LEqual (Arg0, 
                    0x81))))
                {
                    Notify (\_PR.CPU2, Arg0)
                }
                If (LOr (LAnd (And (PDC3, 0x08), LOr (LEqual (Arg0, 
                    0x80), LEqual (Arg0, 0x82))), LAnd (And (PDC3, 0x10), LEqual (Arg0, 
                    0x81))))
                {
                    Notify (\_PR.CPU3, Arg0)
                }
                If (LOr (LAnd (And (PDC4, 0x08), LOr (LEqual (Arg0, 
                    0x80), LEqual (Arg0, 0x82))), LAnd (And (PDC4, 0x10), LEqual (Arg0, 
                    0x81))))
                {
                    Notify (\_PR.CPU4, Arg0)
                }
                If (LOr (LAnd (And (PDC5, 0x08), LOr (LEqual (Arg0, 
                    0x80), LEqual (Arg0, 0x82))), LAnd (And (PDC5, 0x10), LEqual (Arg0, 
                    0x81))))
                {
                    Notify (\_PR.CPU5, Arg0)
                }
                If (LOr (LAnd (And (PDC6, 0x08), LOr (LEqual (Arg0, 
                    0x80), LEqual (Arg0, 0x82))), LAnd (And (PDC6, 0x10), LEqual (Arg0, 
                    0x81))))
                {
                    Notify (\_PR.CPU6, Arg0)
                }
                If (LOr (LAnd (And (PDC7, 0x08), LOr (LEqual (Arg0, 
                    0x80), LEqual (Arg0, 0x82))), LAnd (And (PDC7, 0x10), LEqual (Arg0, 
                    0x81))))
                {
                    Notify (\_PR.CPU7, Arg0)
                }
            }
            Else
            {
                If (LOr (LEqual (Arg0, 0x80), LOr (LEqual (Arg0, 0x81), LEqual (
                    Arg0, 0x82))))
                {
                    Notify (\_PR.CPU0, Arg0)
                }
            }
        }
    }
    OperationRegion (MNVS, SystemMemory, 0xBF79D018, 0x1000)
    Field (MNVS, DWordAcc, NoLock, Preserve)
    {
        Offset (0xD00), 
        GAPA,   32, 
        GAPL,   32, 
        DCKI,   32, 
        DCKS,   32, 
        VCDL,   1, 
        VCDC,   1, 
        VCDT,   1, 
        VCDD,   1, 
            ,   1, 
        VCSS,   1, 
        VCDB,   1, 
        VCIN,   1, 
        VVPO,   8, 
        BRTN,   8, 
        BRLV,   8, 
        CDFL,   8, 
        CDAH,   8, 
        PMOD,   2, 
        PDIR,   1, 
        PDMA,   1, 
        Offset (0xD17), 
        LFDC,   1, 
        Offset (0xD18), 
        C2NA,   1, 
        C3NA,   1, 
        C4NA,   1, 
        C6NA,   1, 
        C7NA,   1, 
        Offset (0xD19), 
        Offset (0xD1A), 
            ,   2, 
            ,   1, 
        NHPS,   1, 
        NPME,   1, 
        Offset (0xD1B), 
        UOPT,   8, 
        BTID,   32, 
        DPP0,   1, 
        DPP1,   1, 
        DPP2,   1, 
        DPP3,   1, 
        DPP4,   1, 
        DPP5,   1, 
        Offset (0xD21), 
        Offset (0xD22), 
        TCRT,   16, 
        TPSV,   16, 
        TTC1,   16, 
        TTC2,   16, 
        TTSP,   16, 
        SRAH,   8, 
        SRHE,   8, 
        SRE1,   8, 
        SRE2,   8, 
        SRE3,   8, 
        SRE4,   8, 
        SRE5,   8, 
        SRE6,   8, 
        SRU1,   8, 
        SRU2,   8, 
        SRU3,   8, 
        SRU7,   8, 
        SRU4,   8, 
        SRU5,   8, 
        SRU8,   8, 
        SRPB,   8, 
        SRLP,   8, 
        SRSA,   8, 
        SRSM,   8, 
        CWAC,   1, 
        CWAS,   1, 
        CWUE,   1, 
        CWUS,   1, 
        Offset (0xD40), 
        CWAP,   16, 
        CWAT,   16, 
        DBGC,   1, 
        Offset (0xD45), 
        FS1L,   16, 
        FS1M,   16, 
        FS1H,   16, 
        FS2L,   16, 
        FS2M,   16, 
        FS2H,   16, 
        FS3L,   16, 
        FS3M,   16, 
        FS3H,   16, 
        TATC,   1, 
            ,   6, 
        TATL,   1, 
        TATW,   8, 
        TNFT,   4, 
        TNTT,   4, 
        TDFA,   4, 
        TDTA,   4, 
        TDFD,   4, 
        TDTD,   4, 
        TCFA,   4, 
        TCTA,   4, 
        TCFD,   4, 
        TCTD,   4, 
        TSFT,   4, 
        TSTT,   4, 
        TIT0,   8, 
        TCR0,   16, 
        TPS0,   16, 
        TIT1,   8, 
        TCR1,   16, 
        TPS1,   16, 
        TIT2,   8, 
        TCR2,   16, 
        TPS2,   16, 
        TIF0,   8, 
        TIF1,   8, 
        TIF2,   8, 
        Offset (0xD78), 
        BTHI,   1, 
        Offset (0xD79), 
        HDIR,   1, 
        HDEH,   1, 
        HDSP,   1, 
        HDPP,   1, 
        HDUB,   1, 
        HDMC,   1, 
        Offset (0xD7A), 
        TPME,   8, 
        BIDE,   4, 
        IDET,   4, 
            ,   1, 
        DTSE,   1, 
        Offset (0xD7D), 
        DTS0,   8, 
        DTS1,   8, 
        DT00,   1, 
        DT01,   1, 
        DT02,   1, 
        DT03,   1, 
        Offset (0xD80), 
        LIDB,   1, 
        C4WR,   1, 
        C4AC,   1, 
        ODDX,   1, 
        CMPR,   1, 
        ILNF,   1, 
        PLUX,   1, 
        Offset (0xD81), 
        Offset (0xD8C), 
            ,   4, 
            ,   1, 
        IDMM,   1, 
        Offset (0xD8D), 
            ,   3, 
            ,   1, 
            ,   1, 
        LIDS,   1, 
        Offset (0xD8E), 
        Offset (0xD8F), 
            ,   4, 
        Offset (0xD90), 
        TCG0,   1, 
        TCG1,   1, 
        Offset (0xD91), 
        SWGP,   8, 
        IPMS,   8, 
        IPMB,   120, 
        IPMR,   24, 
        IPMO,   24, 
        IPMA,   8, 
        VIGD,   1, 
        VDSC,   1, 
            ,   2, 
        VDSP,   1, 
        Offset (0xDAA), 
        Offset (0xDAD), 
        ASFT,   8, 
        PL1L,   8, 
        PL1M,   8, 
        CHKC,   32, 
        CHKE,   32, 
        ATRB,   32, 
        Offset (0xDBD), 
        PPCR,   8, 
        TPCR,   5, 
        Offset (0xDBF), 
        ATMB,   128, 
        PPCA,   8, 
        TPCA,   5, 
        Offset (0xDD1), 
        BFWB,   296, 
        OSPX,   1, 
        OSC4,   1, 
        PCWF,   1, 
        Offset (0xDF7), 
        SPEN,   1, 
        SCRM,   1, 
        GFPL,   1, 
        ETAU,   1, 
        TDNV,   1, 
        Offset (0xDF8), 
        FTPS,   8, 
        HIST,   8, 
        LPST,   8, 
        LWST,   8, 
        Offset (0xDFF), 
        MTAU,   8, 
        Offset (0xE20), 
        HPET,   32, 
        PKLI,   16, 
        VLCX,   16, 
        VNIT,   8, 
        VBD0,   8, 
        VBDT,   128, 
        VBPL,   16, 
        VBPH,   16, 
        VBML,   8, 
        VBMH,   8, 
        VEDI,   1024, 
        PDCI,   16, 
        DGTP,   1, 
        XECU,   1, 
        CPUC,   1, 
        Offset (0xEC3)
    }
    Field (MNVS, ByteAcc, NoLock, Preserve)
    {
        Offset (0xB00), 
        WITM,   8, 
        WSEL,   8, 
        WLS0,   8, 
        WLS1,   8, 
        WLS2,   8, 
        WLS3,   8, 
        WLS4,   8, 
        WLS5,   8, 
        WLS6,   8, 
        WLS7,   8, 
        WLS8,   8, 
        WLS9,   8, 
        WLSA,   8, 
        WLSB,   8, 
        WLSC,   8, 
        WLSD,   8, 
        WENC,   8, 
        WKBD,   8, 
        WPTY,   8, 
        WPAS,   1032, 
        WPNW,   1032, 
        WSPM,   8, 
        WSPS,   8, 
        WSMN,   8, 
        WSMX,   8, 
        WSEN,   8, 
        WSKB,   8
    }
    Field (MNVS, ByteAcc, NoLock, Preserve)
    {
        Offset (0xA00), 
        DBGS,   1024
    }
    OperationRegion (GNVS, SystemMemory, 0xBF73FE18, 0x01A6)
    Field (GNVS, AnyAcc, Lock, Preserve)
    {
        OSYS,   16, 
        SMIF,   8, 
        PRM0,   8, 
        PRM1,   8, 
        Offset (0x10), 
        PWRS,   8, 
        Offset (0x1E), 
        Offset (0x25), 
        REVN,   8, 
        Offset (0x28), 
        APIC,   8, 
        TCNT,   8, 
        PCP0,   8, 
        PCP1,   8, 
        PPCM,   8, 
        PPMF,   32, 
        C67L,   8, 
        Offset (0x3C), 
        IGDS,   8, 
        TLST,   8, 
        CADL,   8, 
        PADL,   8, 
        CSTE,   16, 
        NSTE,   16, 
        SSTE,   16, 
        NDID,   8, 
        DID1,   32, 
        DID2,   32, 
        DID3,   32, 
        DID4,   32, 
        DID5,   32, 
        KSV0,   32, 
        KSV1,   8, 
        Offset (0x67), 
        BLCS,   8, 
        BRTL,   8, 
        Offset (0x78), 
        TPMP,   8, 
        Offset (0x7A), 
        MORD,   8, 
        TCGP,   8, 
        PPRP,   32, 
        PPRQ,   8, 
        LPPR,   8, 
        GTF0,   56, 
        GTF2,   56, 
        IDEM,   8, 
        GTF1,   56, 
        BID,    8, 
        Offset (0xAA), 
        ASLB,   32, 
        IBTT,   8, 
        IPAT,   8, 
        ITVF,   8, 
        ITVM,   8, 
        IPSC,   8, 
        IBLC,   8, 
        IBIA,   8, 
        ISSC,   8, 
        I409,   8, 
        I509,   8, 
        I609,   8, 
        I709,   8, 
        IPCF,   8, 
        IDMS,   8, 
        IF1E,   8, 
        HVCO,   8, 
        NXD1,   32, 
        NXD2,   32, 
        NXD3,   32, 
        NXD4,   32, 
        NXD5,   32, 
        NXD6,   32, 
        NXD7,   32, 
        NXD8,   32, 
        GSMI,   8, 
        PAVP,   8, 
        Offset (0xE1), 
        OSCC,   8, 
        NEXP,   8, 
        SDGV,   8, 
        SDDV,   8, 
        Offset (0xEB), 
        DSEN,   8, 
        ECON,   8, 
        Offset (0xEE), 
        CTYP,   8, 
        L01C,   8, 
        VFN0,   8, 
        VFN1,   8, 
        Offset (0x100), 
        NVGA,   32, 
        NVHA,   32, 
        AMDA,   32, 
        DID6,   32, 
        DID7,   32, 
        DID8,   32, 
        EBAS,   32, 
        CPSP,   32, 
        EECP,   32, 
        EVCP,   32, 
        XBAS,   32, 
        OBS1,   32, 
        OBS2,   32, 
        OBS3,   32, 
        OBS4,   32, 
        OBS5,   32, 
        OBS6,   32, 
        OBS7,   32, 
        OBS8,   32, 
        Offset (0x157), 
        ATMC,   8, 
        PTMC,   8, 
        ATRA,   8, 
        PTRA,   8, 
        PNHM,   32, 
        TBAB,   32, 
        TBAH,   32, 
        RTIP,   8, 
        TSOD,   8, 
        ATPC,   8, 
        PTPC,   8, 
        PFLV,   8, 
        BREV,   8, 
        HGMD,   8, 
        PWOK,   8, 
        HLRS,   8, 
        DSEL,   8, 
        ESEL,   8, 
        PSEL,   8, 
        PWEN,   8, 
        PRST,   8, 
        DPBM,   8, 
        DPCM,   8, 
        DPDM,   8, 
        ALFP,   8, 
        IMON,   8, 
        PDTS,   8, 
        PKGA,   8, 
        PAMT,   8, 
        AC0F,   8, 
        AC1F,   8
    }
    Scope (\_SB)
    {
        Method (_INI, 0, NotSerialized)
        {
            If (CondRefOf (\_OSI, Local0))
            {
                If (\_OSI ("Windows 2001"))
                {
                    Store (0x01, \WNTF)
                    Store (0x01, \WXPF)
                    Store (0x00, \WSPV)
                }
                If (\_OSI ("Windows 2001 SP1"))
                {
                    Store (0x01, \WSPV)
                }
                If (\_OSI ("Windows 2001 SP2"))
                {
                    Store (0x02, \WSPV)
                }
                If (\_OSI ("Windows 2006"))
                {
                    Store (0x01, \WVIS)
                }
                If (\_OSI ("Windows 2009"))
                {
                    Store (0x01, \WIN7)
                }
                If (\_OSI ("Linux"))
                {
                    Store (0x01, \LNUX)
                }
                If (\_OSI ("FreeBSD"))
                {
                    Store (0x01, \LNUX)
                }
            }
            Else
            {
                If (LEqual (\SCMP (\_OS, "Microsoft Windows NT"), Zero))
                {
                    Store (0x01, \WNTF)
                }
            }
            Store (One, WNTF)
            Store (One, WXPF)
            Store (0x02, WSPV)
            Store (One, WVIS)
            If (LGreaterEqual (\_REV, 0x02))
            {
                Store (0x01, \H8DR)
            }
            Store (0x01, \OSIF)
            Store (\_SB.PCI0.LPC.EC.AC._PSR (), \PWRS)
            \_SB.PCI0.LPC.MOU.MHID ()
            If (\LNUX)
            {
                \_SB.PCI0.LPC.EC.SAUM (0x02)
                \UCMS (0x1C)
            }
            Store (\SRAH, \_SB.PCI0.RID)
            If (VIGD)
            {
                Store (\SRHE, \_SB.PCI0.VID.RID)
            }
            Else
            {
                Store (\SRHE, \_SB.PCI0.PEG.RID)
            }
            Store (\SRE1, \_SB.PCI0.EXP1.RID)
            Store (\SRE2, \_SB.PCI0.EXP2.RID)
            Store (\SRE4, \_SB.PCI0.EXP4.RID)
            Store (\SRE4, \_SB.PCI0.EXP5.RID)
            Store (\SRE4, \_SB.PCI0.EXP7.RID)
            Store (\SRU7, \_SB.PCI0.EHC1.RID)
            Store (\SRU8, \_SB.PCI0.EHC2.RID)
            Store (\SRLP, \_SB.PCI0.LPC.RID)
            Store (\SRSA, \_SB.PCI0.SAT1.RID)
            Store (\SRSM, \_SB.PCI0.SMBU.RID)
            If (VDSP)
            {
                Store (\VHYB (0x05, 0x00), Local1)
                If (And (Local1, 0x80))
                {
                    If (\WIN7)
                    {
                        If (LNotEqual (And (Local1, 0x03), 0x03))
                        {
                            \VHYB (0x06, 0x03)
                        }
                    }
                    Else
                    {
                        If (LEqual (And (Local1, 0x03), 0x03))
                        {
                            \VHYB (0x06, 0x02)
                        }
                    }
                }
            }
            \UCMS (0x1D)
        }
        Device (LNKA)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x01)
            Method (_STA, 0, NotSerialized)
            {
                If (LNot (VPIR (\_SB.PCI0.LPC.PIRA)))
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }
            Name (_PRS, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared, )
                    {3,4,5,6,7,9,10,11}
            })
            Method (_DIS, 0, NotSerialized)
            {
                Or (\_SB.PCI0.LPC.PIRA, 0x80, \_SB.PCI0.LPC.PIRA)
            }
            Name (BUFA, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared, _Y00)
                    {}
            })
            CreateWordField (BUFA, \_SB.LNKA._Y00._INT, IRA1)
            Method (_CRS, 0, NotSerialized)
            {
                And (\_SB.PCI0.LPC.PIRA, 0x8F, Local0)
                If (VPIR (Local0))
                {
                    ShiftLeft (0x01, Local0, IRA1)
                }
                Else
                {
                    Store (0x00, IRA1)
                }
                Return (BUFA)
            }
            Method (_SRS, 1, NotSerialized)
            {
                CreateWordField (Arg0, 0x01, IRA2)
                FindSetRightBit (IRA2, Local0)
                And (\_SB.PCI0.LPC.PIRA, 0x70, Local1)
                Or (Local1, Decrement (Local0), Local1)
                Store (Local1, \_SB.PCI0.LPC.PIRA)
            }
        }
        Device (LNKB)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x02)
            Method (_STA, 0, NotSerialized)
            {
                If (LNot (VPIR (\_SB.PCI0.LPC.PIRB)))
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }
            Name (_PRS, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared, )
                    {3,4,5,6,7,9,10,11}
            })
            Method (_DIS, 0, NotSerialized)
            {
                Or (\_SB.PCI0.LPC.PIRB, 0x80, \_SB.PCI0.LPC.PIRB)
            }
            Name (BUFB, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared, _Y01)
                    {}
            })
            CreateWordField (BUFB, \_SB.LNKB._Y01._INT, IRB1)
            Method (_CRS, 0, NotSerialized)
            {
                And (\_SB.PCI0.LPC.PIRB, 0x8F, Local0)
                If (VPIR (Local0))
                {
                    ShiftLeft (0x01, Local0, IRB1)
                }
                Else
                {
                    Store (0x00, IRB1)
                }
                Return (BUFB)
            }
            Method (_SRS, 1, NotSerialized)
            {
                CreateWordField (Arg0, 0x01, IRB2)
                FindSetRightBit (IRB2, Local0)
                And (\_SB.PCI0.LPC.PIRB, 0x70, Local1)
                Or (Local1, Decrement (Local0), Local1)
                Store (Local1, \_SB.PCI0.LPC.PIRB)
            }
        }
        Device (LNKC)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x03)
            Method (_STA, 0, NotSerialized)
            {
                If (LNot (VPIR (\_SB.PCI0.LPC.PIRC)))
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }
            Name (_PRS, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared, )
                    {3,4,5,6,7,9,10,11}
            })
            Method (_DIS, 0, NotSerialized)
            {
                Or (\_SB.PCI0.LPC.PIRC, 0x80, \_SB.PCI0.LPC.PIRC)
            }
            Name (BUFC, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared, _Y02)
                    {}
            })
            CreateWordField (BUFC, \_SB.LNKC._Y02._INT, IRC1)
            Method (_CRS, 0, NotSerialized)
            {
                And (\_SB.PCI0.LPC.PIRC, 0x8F, Local0)
                If (VPIR (Local0))
                {
                    ShiftLeft (0x01, Local0, IRC1)
                }
                Else
                {
                    Store (0x00, IRC1)
                }
                Return (BUFC)
            }
            Method (_SRS, 1, NotSerialized)
            {
                CreateWordField (Arg0, 0x01, IRC2)
                FindSetRightBit (IRC2, Local0)
                And (\_SB.PCI0.LPC.PIRC, 0x70, Local1)
                Or (Local1, Decrement (Local0), Local1)
                Store (Local1, \_SB.PCI0.LPC.PIRC)
            }
        }
        Device (LNKD)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x04)
            Method (_STA, 0, NotSerialized)
            {
                If (LNot (VPIR (\_SB.PCI0.LPC.PIRD)))
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }
            Name (_PRS, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared, )
                    {3,4,5,6,7,9,10,11}
            })
            Method (_DIS, 0, NotSerialized)
            {
                Or (\_SB.PCI0.LPC.PIRD, 0x80, \_SB.PCI0.LPC.PIRD)
            }
            Name (BUFD, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared, _Y03)
                    {}
            })
            CreateWordField (BUFD, \_SB.LNKD._Y03._INT, IRD1)
            Method (_CRS, 0, NotSerialized)
            {
                And (\_SB.PCI0.LPC.PIRD, 0x8F, Local0)
                If (VPIR (Local0))
                {
                    ShiftLeft (0x01, Local0, IRD1)
                }
                Else
                {
                    Store (0x00, IRD1)
                }
                Return (BUFD)
            }
            Method (_SRS, 1, NotSerialized)
            {
                CreateWordField (Arg0, 0x01, IRD2)
                FindSetRightBit (IRD2, Local0)
                And (\_SB.PCI0.LPC.PIRD, 0x70, Local1)
                Or (Local1, Decrement (Local0), Local1)
                Store (Local1, \_SB.PCI0.LPC.PIRD)
            }
        }
        Device (LNKE)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x05)
            Method (_STA, 0, NotSerialized)
            {
                If (LNot (VPIR (\_SB.PCI0.LPC.PIRE)))
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }
            Name (_PRS, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared, )
                    {3,4,5,6,7,9,10,11}
            })
            Method (_DIS, 0, NotSerialized)
            {
                Or (\_SB.PCI0.LPC.PIRE, 0x80, \_SB.PCI0.LPC.PIRE)
            }
            Name (BUFE, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared, _Y04)
                    {}
            })
            CreateWordField (BUFE, \_SB.LNKE._Y04._INT, IRE1)
            Method (_CRS, 0, NotSerialized)
            {
                And (\_SB.PCI0.LPC.PIRE, 0x8F, Local0)
                If (VPIR (Local0))
                {
                    ShiftLeft (0x01, Local0, IRE1)
                }
                Else
                {
                    Store (0x00, IRE1)
                }
                Return (BUFE)
            }
            Method (_SRS, 1, NotSerialized)
            {
                CreateWordField (Arg0, 0x01, IRE2)
                FindSetRightBit (IRE2, Local0)
                And (\_SB.PCI0.LPC.PIRE, 0x70, Local1)
                Or (Local1, Decrement (Local0), Local1)
                Store (Local1, \_SB.PCI0.LPC.PIRE)
            }
        }
        Device (LNKF)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x06)
            Method (_STA, 0, NotSerialized)
            {
                If (LNot (VPIR (\_SB.PCI0.LPC.PIRF)))
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }
            Name (_PRS, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared, )
                    {3,4,5,6,7,9,10,11}
            })
            Method (_DIS, 0, NotSerialized)
            {
                Or (\_SB.PCI0.LPC.PIRF, 0x80, \_SB.PCI0.LPC.PIRF)
            }
            Name (BUFF, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared, _Y05)
                    {}
            })
            CreateWordField (BUFF, \_SB.LNKF._Y05._INT, IRF1)
            Method (_CRS, 0, NotSerialized)
            {
                And (\_SB.PCI0.LPC.PIRF, 0x8F, Local0)
                If (VPIR (Local0))
                {
                    ShiftLeft (0x01, Local0, IRF1)
                }
                Else
                {
                    Store (0x00, IRF1)
                }
                Return (BUFF)
            }
            Method (_SRS, 1, NotSerialized)
            {
                CreateWordField (Arg0, 0x01, IRF2)
                FindSetRightBit (IRF2, Local0)
                And (\_SB.PCI0.LPC.PIRF, 0x70, Local1)
                Or (Local1, Decrement (Local0), Local1)
                Store (Local1, \_SB.PCI0.LPC.PIRF)
            }
        }
        Device (LNKG)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x07)
            Method (_STA, 0, NotSerialized)
            {
                If (LNot (VPIR (\_SB.PCI0.LPC.PIRG)))
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }
            Name (_PRS, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared, )
                    {3,4,5,6,7,9,10,11}
            })
            Method (_DIS, 0, NotSerialized)
            {
                Or (\_SB.PCI0.LPC.PIRG, 0x80, \_SB.PCI0.LPC.PIRG)
            }
            Name (BUFG, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared, _Y06)
                    {}
            })
            CreateWordField (BUFG, \_SB.LNKG._Y06._INT, IRG1)
            Method (_CRS, 0, NotSerialized)
            {
                And (\_SB.PCI0.LPC.PIRG, 0x8F, Local0)
                If (VPIR (Local0))
                {
                    ShiftLeft (0x01, Local0, IRG1)
                }
                Else
                {
                    Store (0x00, IRG1)
                }
                Return (BUFG)
            }
            Method (_SRS, 1, NotSerialized)
            {
                CreateWordField (Arg0, 0x01, IRG2)
                FindSetRightBit (IRG2, Local0)
                And (\_SB.PCI0.LPC.PIRG, 0x70, Local1)
                Or (Local1, Decrement (Local0), Local1)
                Store (Local1, \_SB.PCI0.LPC.PIRG)
            }
        }
        Device (LNKH)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x08)
            Method (_STA, 0, NotSerialized)
            {
                If (LNot (VPIR (\_SB.PCI0.LPC.PIRH)))
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }
            Name (_PRS, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared, )
                    {3,4,5,6,7,9,10,11}
            })
            Method (_DIS, 0, NotSerialized)
            {
                Or (\_SB.PCI0.LPC.PIRH, 0x80, \_SB.PCI0.LPC.PIRH)
            }
            Name (BUFH, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared, _Y07)
                    {}
            })
            CreateWordField (BUFH, \_SB.LNKH._Y07._INT, IRH1)
            Method (_CRS, 0, NotSerialized)
            {
                And (\_SB.PCI0.LPC.PIRH, 0x8F, Local0)
                If (VPIR (Local0))
                {
                    ShiftLeft (0x01, Local0, IRH1)
                }
                Else
                {
                    Store (0x00, IRH1)
                }
                Return (BUFH)
            }
            Method (_SRS, 1, NotSerialized)
            {
                CreateWordField (Arg0, 0x01, IRH2)
                FindSetRightBit (IRH2, Local0)
                And (\_SB.PCI0.LPC.PIRH, 0x70, Local1)
                Or (Local1, Decrement (Local0), Local1)
                Store (Local1, \_SB.PCI0.LPC.PIRH)
            }
        }
        Method (VPIR, 1, NotSerialized)
        {
            Store (0x01, Local0)
            If (And (Arg0, 0x80))
            {
                Store (0x00, Local0)
            }
            Else
            {
                And (Arg0, 0x0F, Local1)
                If (LLess (Local1, 0x03))
                {
                    Store (0x00, Local0)
                }
                Else
                {
                    If (LOr (LEqual (Local1, 0x08), LEqual (Local1, 0x0D)))
                    {
                        Store (0x00, Local0)
                    }
                }
            }
            Return (Local0)
        }
        Device (MEM)
        {
            Name (_HID, EisaId ("PNP0C01"))
            Name (MEMS, ResourceTemplate ()
            {
                Memory32Fixed (ReadWrite,
                    0x00000000,         // Address Base
                    0x000A0000,         // Address Length
                    )
                Memory32Fixed (ReadOnly,
                    0x000C0000,         // Address Base
                    0x00000000,         // Address Length
                    _Y08)
                Memory32Fixed (ReadOnly,
                    0x000C4000,         // Address Base
                    0x00000000,         // Address Length
                    _Y09)
                Memory32Fixed (ReadOnly,
                    0x000C8000,         // Address Base
                    0x00000000,         // Address Length
                    _Y0A)
                Memory32Fixed (ReadOnly,
                    0x000CC000,         // Address Base
                    0x00000000,         // Address Length
                    _Y0B)
                Memory32Fixed (ReadOnly,
                    0x000D0000,         // Address Base
                    0x00000000,         // Address Length
                    _Y0C)
                Memory32Fixed (ReadOnly,
                    0x000D4000,         // Address Base
                    0x00000000,         // Address Length
                    _Y0D)
                Memory32Fixed (ReadOnly,
                    0x000D8000,         // Address Base
                    0x00000000,         // Address Length
                    _Y0E)
                Memory32Fixed (ReadOnly,
                    0x000DC000,         // Address Base
                    0x00000000,         // Address Length
                    _Y0F)
                Memory32Fixed (ReadOnly,
                    0x000E0000,         // Address Base
                    0x00000000,         // Address Length
                    _Y10)
                Memory32Fixed (ReadOnly,
                    0x000E4000,         // Address Base
                    0x00000000,         // Address Length
                    _Y11)
                Memory32Fixed (ReadOnly,
                    0x000E8000,         // Address Base
                    0x00000000,         // Address Length
                    _Y12)
                Memory32Fixed (ReadOnly,
                    0x000EC000,         // Address Base
                    0x00000000,         // Address Length
                    _Y13)
                Memory32Fixed (ReadOnly,
                    0x000F0000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x00100000,         // Address Base
                    0x01EE0000,         // Address Length
                    _Y14)
                Memory32Fixed (ReadOnly,
                    0xFEC00000,         // Address Base
                    0x00140000,         // Address Length
                    _Y15)
                Memory32Fixed (ReadOnly,
                    0xFED4C000,         // Address Base
                    0x012B4000,         // Address Length
                    _Y16)
            })
            CreateDWordField (MEMS, \_SB.MEM._Y08._LEN, MC0L)
            CreateDWordField (MEMS, \_SB.MEM._Y09._LEN, MC4L)
            CreateDWordField (MEMS, \_SB.MEM._Y0A._LEN, MC8L)
            CreateDWordField (MEMS, \_SB.MEM._Y0B._LEN, MCCL)
            CreateDWordField (MEMS, \_SB.MEM._Y0C._LEN, MD0L)
            CreateDWordField (MEMS, \_SB.MEM._Y0D._LEN, MD4L)
            CreateDWordField (MEMS, \_SB.MEM._Y0E._LEN, MD8L)
            CreateDWordField (MEMS, \_SB.MEM._Y0F._LEN, MDCL)
            CreateDWordField (MEMS, \_SB.MEM._Y10._LEN, ME0L)
            CreateDWordField (MEMS, \_SB.MEM._Y11._LEN, ME4L)
            CreateDWordField (MEMS, \_SB.MEM._Y12._LEN, ME8L)
            CreateDWordField (MEMS, \_SB.MEM._Y13._LEN, MECL)
            CreateBitField (MEMS, \_SB.MEM._Y08._RW, MC0W)
            CreateBitField (MEMS, \_SB.MEM._Y09._RW, MC4W)
            CreateBitField (MEMS, \_SB.MEM._Y0A._RW, MC8W)
            CreateBitField (MEMS, \_SB.MEM._Y0B._RW, MCCW)
            CreateBitField (MEMS, \_SB.MEM._Y0C._RW, MD0W)
            CreateBitField (MEMS, \_SB.MEM._Y0D._RW, MD4W)
            CreateBitField (MEMS, \_SB.MEM._Y0E._RW, MD8W)
            CreateBitField (MEMS, \_SB.MEM._Y0F._RW, MDCW)
            CreateBitField (MEMS, \_SB.MEM._Y10._RW, ME0W)
            CreateBitField (MEMS, \_SB.MEM._Y11._RW, ME4W)
            CreateBitField (MEMS, \_SB.MEM._Y12._RW, ME8W)
            CreateBitField (MEMS, \_SB.MEM._Y13._RW, MECW)
            CreateDWordField (MEMS, \_SB.MEM._Y14._BAS, MEB1)
            CreateDWordField (MEMS, \_SB.MEM._Y14._LEN, MEL1)
            CreateDWordField (MEMS, \_SB.MEM._Y15._LEN, MEL2)
            CreateDWordField (MEMS, \_SB.MEM._Y16._LEN, MEL3)
            Method (_CRS, 0, NotSerialized)
            {
                And (\_SB.PCI0.PAM1, 0x03, Local0)
                If (Local0)
                {
                    Store (0x4000, MC0L)
                    If (And (Local0, 0x02))
                    {
                        Store (0x01, MC0W)
                    }
                }
                And (\_SB.PCI0.PAM1, 0x30, Local0)
                If (Local0)
                {
                    Store (0x4000, MC4L)
                    If (And (Local0, 0x20))
                    {
                        Store (0x01, MC4W)
                    }
                }
                And (\_SB.PCI0.PAM2, 0x03, Local0)
                If (Local0)
                {
                    Store (0x4000, MC8L)
                    If (And (Local0, 0x02))
                    {
                        Store (0x01, MC8W)
                    }
                }
                And (\_SB.PCI0.PAM2, 0x30, Local0)
                If (Local0)
                {
                    Store (0x4000, MCCL)
                    If (And (Local0, 0x20))
                    {
                        Store (0x01, MCCW)
                    }
                }
                And (\_SB.PCI0.PAM3, 0x03, Local0)
                If (Local0)
                {
                    Store (0x4000, MD0L)
                    If (And (Local0, 0x02))
                    {
                        Store (0x01, MD0W)
                    }
                }
                And (\_SB.PCI0.PAM3, 0x30, Local0)
                If (Local0)
                {
                    Store (0x4000, MD4L)
                    If (And (Local0, 0x20))
                    {
                        Store (0x01, MD4W)
                    }
                }
                And (\_SB.PCI0.PAM4, 0x03, Local0)
                If (Local0)
                {
                    Store (0x4000, MD8L)
                    If (And (Local0, 0x02))
                    {
                        Store (0x01, MD8W)
                    }
                }
                And (\_SB.PCI0.PAM4, 0x30, Local0)
                If (Local0)
                {
                    Store (0x4000, MDCL)
                    If (And (Local0, 0x20))
                    {
                        Store (0x01, MDCW)
                    }
                }
                And (\_SB.PCI0.PAM5, 0x03, Local0)
                If (Local0)
                {
                    Store (0x4000, ME0L)
                    If (And (Local0, 0x02))
                    {
                        Store (0x01, ME0W)
                    }
                }
                And (\_SB.PCI0.PAM5, 0x30, Local0)
                If (Local0)
                {
                    Store (0x4000, ME4L)
                    If (And (Local0, 0x20))
                    {
                        Store (0x01, ME4W)
                    }
                }
                And (\_SB.PCI0.PAM6, 0x03, Local0)
                If (Local0)
                {
                    Store (0x4000, ME8L)
                    If (And (Local0, 0x02))
                    {
                        Store (0x01, ME8W)
                    }
                }
                And (\_SB.PCI0.PAM6, 0x30, Local0)
                If (Local0)
                {
                    Store (0x4000, MECL)
                    If (And (Local0, 0x20))
                    {
                        Store (0x01, MECW)
                    }
                }
                Subtract (\MEMX, MEB1, MEL1)
                If (LNotEqual (\_SB.PCI0.LPC.TPM._STA (), 0x0F))
                {
                    Store (0x01400000, MEL2)
                    Store (0x00, MEL3)
                }
                Return (MEMS)
            }
        }
        Device (LID)
        {
            Name (_HID, EisaId ("PNP0C0D"))
            Method (_LID, 0, NotSerialized)
            {
                If (LAnd (LEqual (\ILNF, 0x00), LEqual (\PLUX, 0x00)))
                {
                    If (\H8DR)
                    {
                        Return (\_SB.PCI0.LPC.EC.HPLD)
                    }
                    Else
                    {
                        If (And (\RBEC (0x46), 0x04))
                        {
                            Return (0x01)
                        }
                        Else
                        {
                            Return (0x00)
                        }
                    }
                }
                Else
                {
                    Return (0x01)
                }
            }
            Method (_PRW, 0, NotSerialized)
            {
                Return (Package (0x02)
                {
                    0x1D, 
                    0x03
                })
            }
            Method (_PSW, 1, NotSerialized)
            {
                If (\H8DR)
                {
                    If (Arg0)
                    {
                        Store (0x01, \_SB.PCI0.LPC.EC.HWLO)
                    }
                    Else
                    {
                        Store (0x00, \_SB.PCI0.LPC.EC.HWLO)
                    }
                }
                Else
                {
                    If (Arg0)
                    {
                        \MBEC (0x32, 0xFF, 0x04)
                    }
                    Else
                    {
                        \MBEC (0x32, 0xFB, 0x00)
                    }
                }
            }
        }
        Device (SLPB)
        {
            Name (_HID, EisaId ("PNP0C0E"))
            Method (_PRW, 0, NotSerialized)
            {
                Return (Package (0x02)
                {
                    0x1D, 
                    0x03
                })
            }
            Method (_PSW, 1, NotSerialized)
            {
                If (\H8DR)
                {
                    If (Arg0)
                    {
                        Store (0x01, \_SB.PCI0.LPC.EC.HWFN)
                    }
                    Else
                    {
                        Store (0x00, \_SB.PCI0.LPC.EC.HWFN)
                    }
                }
                Else
                {
                    If (Arg0)
                    {
                        \MBEC (0x32, 0xFF, 0x10)
                    }
                    Else
                    {
                        \MBEC (0x32, 0xEF, 0x00)
                    }
                }
            }
        }
        Device (PCI0)
        {
            Name (_BBN, 0x00)
            Name (_ADR, 0x00)
            Name (RID, 0x00)
            Name (_S3D, 0x02)
            Name (LRRT, Package (0x15)
            {
                Package (0x04)
                {
                    0x0001FFFF, 
                    0x00, 
                    \_SB.LNKA, 
                    0x00
                }, 
                Package (0x04)
                {
                    0x0002FFFF, 
                    0x00, 
                    \_SB.LNKA, 
                    0x00
                }, 
                Package (0x04)
                {
                    0x0016FFFF, 
                    0x00, 
                    \_SB.LNKA, 
                    0x00
                }, 
                Package (0x04)
                {
                    0x0016FFFF, 
                    0x01, 
                    \_SB.LNKD, 
                    0x00
                }, 
                Package (0x04)
                {
                    0x0016FFFF, 
                    0x02, 
                    \_SB.LNKC, 
                    0x00
                }, 
                Package (0x04)
                {
                    0x0016FFFF, 
                    0x03, 
                    \_SB.LNKB, 
                    0x00
                }, 
                Package (0x04)
                {
                    0x0019FFFF, 
                    0x00, 
                    \_SB.LNKE, 
                    0x00
                }, 
                Package (0x04)
                {
                    0x001AFFFF, 
                    0x00, 
                    \_SB.LNKA, 
                    0x00
                }, 
                Package (0x04)
                {
                    0x001BFFFF, 
                    0x00, 
                    \_SB.LNKG, 
                    0x00
                }, 
                Package (0x04)
                {
                    0x001CFFFF, 
                    0x00, 
                    \_SB.LNKA, 
                    0x00
                }, 
                Package (0x04)
                {
                    0x001CFFFF, 
                    0x01, 
                    \_SB.LNKB, 
                    0x00
                }, 
                Package (0x04)
                {
                    0x001CFFFF, 
                    0x02, 
                    \_SB.LNKC, 
                    0x00
                }, 
                Package (0x04)
                {
                    0x001CFFFF, 
                    0x03, 
                    \_SB.LNKD, 
                    0x00
                }, 
                Package (0x04)
                {
                    0x001DFFFF, 
                    0x00, 
                    \_SB.LNKH, 
                    0x00
                }, 
                Package (0x04)
                {
                    0x001DFFFF, 
                    0x01, 
                    \_SB.LNKD, 
                    0x00
                }, 
                Package (0x04)
                {
                    0x001DFFFF, 
                    0x02, 
                    \_SB.LNKA, 
                    0x00
                }, 
                Package (0x04)
                {
                    0x001DFFFF, 
                    0x03, 
                    \_SB.LNKC, 
                    0x00
                }, 
                Package (0x04)
                {
                    0x001FFFFF, 
                    0x00, 
                    \_SB.LNKF, 
                    0x00
                }, 
                Package (0x04)
                {
                    0x001FFFFF, 
                    0x01, 
                    \_SB.LNKD, 
                    0x00
                }, 
                Package (0x04)
                {
                    0x001FFFFF, 
                    0x02, 
                    \_SB.LNKC, 
                    0x00
                }, 
                Package (0x04)
                {
                    0x001FFFFF, 
                    0x03, 
                    \_SB.LNKA, 
                    0x00
                }
            })
            Name (ARRT, Package (0x15)
            {
                Package (0x04)
                {
                    0x0001FFFF, 
                    0x00, 
                    0x00, 
                    0x10
                }, 
                Package (0x04)
                {
                    0x0002FFFF, 
                    0x00, 
                    0x00, 
                    0x10
                }, 
                Package (0x04)
                {
                    0x0016FFFF, 
                    0x00, 
                    0x00, 
                    0x10
                }, 
                Package (0x04)
                {
                    0x0016FFFF, 
                    0x01, 
                    0x00, 
                    0x13
                }, 
                Package (0x04)
                {
                    0x0016FFFF, 
                    0x02, 
                    0x00, 
                    0x12
                }, 
                Package (0x04)
                {
                    0x0016FFFF, 
                    0x03, 
                    0x00, 
                    0x11
                }, 
                Package (0x04)
                {
                    0x0019FFFF, 
                    0x00, 
                    0x00, 
                    0x14
                }, 
                Package (0x04)
                {
                    0x001AFFFF, 
                    0x00, 
                    0x00, 
                    0x10
                }, 
                Package (0x04)
                {
                    0x001BFFFF, 
                    0x00, 
                    0x00, 
                    0x16
                }, 
                Package (0x04)
                {
                    0x001CFFFF, 
                    0x00, 
                    0x00, 
                    0x10
                }, 
                Package (0x04)
                {
                    0x001CFFFF, 
                    0x01, 
                    0x00, 
                    0x11
                }, 
                Package (0x04)
                {
                    0x001CFFFF, 
                    0x02, 
                    0x00, 
                    0x12
                }, 
                Package (0x04)
                {
                    0x001CFFFF, 
                    0x03, 
                    0x00, 
                    0x13
                }, 
                Package (0x04)
                {
                    0x001DFFFF, 
                    0x00, 
                    0x00, 
                    0x17
                }, 
                Package (0x04)
                {
                    0x001DFFFF, 
                    0x01, 
                    0x00, 
                    0x13
                }, 
                Package (0x04)
                {
                    0x001DFFFF, 
                    0x02, 
                    0x00, 
                    0x10
                }, 
                Package (0x04)
                {
                    0x001DFFFF, 
                    0x03, 
                    0x00, 
                    0x12
                }, 
                Package (0x04)
                {
                    0x001FFFFF, 
                    0x00, 
                    0x00, 
                    0x15
                }, 
                Package (0x04)
                {
                    0x001FFFFF, 
                    0x01, 
                    0x00, 
                    0x13
                }, 
                Package (0x04)
                {
                    0x001FFFFF, 
                    0x02, 
                    0x00, 
                    0x12
                }, 
                Package (0x04)
                {
                    0x001FFFFF, 
                    0x03, 
                    0x00, 
                    0x10
                }
            })
            Method (_PRT, 0, NotSerialized)
            {
                If (\GPIC)
                {
                    Return (ARRT)
                }
                Else
                {
                    Return (LRRT)
                }
            }
            Name (_HID, EisaId ("PNP0A08"))
            Name (_CID, EisaId ("PNP0A03"))
            OperationRegion (MHCS, PCI_Config, 0x40, 0xC0)
            Field (MHCS, DWordAcc, NoLock, Preserve)
            {
                Offset (0x40), 
                PAM0,   8, 
                PAM1,   8, 
                PAM2,   8, 
                PAM3,   8, 
                PAM4,   8, 
                PAM5,   8, 
                PAM6,   8, 
                Offset (0x7C), 
                    ,   20, 
                TLUD,   12
            }
            Name (_CRS, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                    0x0000,             // Granularity
                    0x0000,             // Range Minimum
                    0x00FE,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x00FF,             // Length
                    ,, )
                IO (Decode16,
                    0x0CF8,             // Range Minimum
                    0x0CF8,             // Range Maximum
                    0x01,               // Alignment
                    0x08,               // Length
                    )
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,             // Granularity
                    0x0000,             // Range Minimum
                    0x0CF7,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x0CF8,             // Length
                    ,, , TypeStatic)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,             // Granularity
                    0x0D00,             // Range Minimum
                    0xFFFF,             // Range Maximum
                    0x0000,             // Translation Offset
                    0xF300,             // Length
                    ,, , TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000A0000,         // Range Minimum
                    0x000BFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00020000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000C0000,         // Range Minimum
                    0x000C3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y17, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000C4000,         // Range Minimum
                    0x000C7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y18, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000C8000,         // Range Minimum
                    0x000CBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y19, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000CC000,         // Range Minimum
                    0x000CFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y1A, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D0000,         // Range Minimum
                    0x000D3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y1B, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D4000,         // Range Minimum
                    0x000D7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y1C, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D8000,         // Range Minimum
                    0x000DBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y1D, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000DC000,         // Range Minimum
                    0x000DFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y1E, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E0000,         // Range Minimum
                    0x000E3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y1F, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E4000,         // Range Minimum
                    0x000E7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y20, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E8000,         // Range Minimum
                    0x000EBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y21, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000EC000,         // Range Minimum
                    0x000EFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y22, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x00100000,         // Range Minimum
                    0xFEBFFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0xFEB00000,         // Length
                    ,, _Y23, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0xFED40000,         // Range Minimum
                    0xFED4BFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x0000C000,         // Length
                    ,, _Y24, AddressRangeMemory, TypeStatic)
            })
            CreateDWordField (_CRS, \_SB.PCI0._Y17._LEN, C0LN)
            CreateDWordField (_CRS, \_SB.PCI0._Y18._LEN, C4LN)
            CreateDWordField (_CRS, \_SB.PCI0._Y19._LEN, C8LN)
            CreateDWordField (_CRS, \_SB.PCI0._Y1A._LEN, CCLN)
            CreateDWordField (_CRS, \_SB.PCI0._Y1B._LEN, D0LN)
            CreateDWordField (_CRS, \_SB.PCI0._Y1C._LEN, D4LN)
            CreateDWordField (_CRS, \_SB.PCI0._Y1D._LEN, D8LN)
            CreateDWordField (_CRS, \_SB.PCI0._Y1E._LEN, DCLN)
            CreateDWordField (_CRS, \_SB.PCI0._Y1F._LEN, E0LN)
            CreateDWordField (_CRS, \_SB.PCI0._Y20._LEN, E4LN)
            CreateDWordField (_CRS, \_SB.PCI0._Y21._LEN, E8LN)
            CreateDWordField (_CRS, \_SB.PCI0._Y22._LEN, ECLN)
            CreateDWordField (_CRS, \_SB.PCI0._Y23._MIN, XXMN)
            CreateDWordField (_CRS, \_SB.PCI0._Y23._MAX, XXMX)
            CreateDWordField (_CRS, \_SB.PCI0._Y23._LEN, XXLN)
            CreateDWordField (_CRS, \_SB.PCI0._Y24._MIN, F4MN)
            CreateDWordField (_CRS, \_SB.PCI0._Y24._MAX, F4MX)
            CreateDWordField (_CRS, \_SB.PCI0._Y24._LEN, F4LN)
            Method (_INI, 0, Serialized)
            {
                If (LNot (\OSIF))
                {
                    \_SB._INI ()
                }
                ShiftLeft (TLUD, 0x14, Local0)
                Store (Local0, \MEMX)
                Store (Local0, XXMN)
                Add (Subtract (XXMX, XXMN), 0x01, XXLN)
                If (LEqual (\TPMP, 0x00))
                {
                    Store (0x00, F4LN)
                }
                If (And (PAM1, 0x03))
                {
                    Store (0x00, C0LN)
                }
                If (And (PAM1, 0x30))
                {
                    Store (0x00, C4LN)
                }
                If (And (PAM2, 0x03))
                {
                    Store (0x00, C8LN)
                }
                If (And (PAM2, 0x30))
                {
                    Store (0x00, CCLN)
                }
                If (And (PAM3, 0x03))
                {
                    Store (0x00, D0LN)
                }
                If (And (PAM3, 0x30))
                {
                    Store (0x00, D4LN)
                }
                If (And (PAM4, 0x03))
                {
                    Store (0x00, D8LN)
                }
                If (And (PAM4, 0x30))
                {
                    Store (0x00, DCLN)
                }
                If (And (PAM5, 0x03))
                {
                    Store (0x00, E0LN)
                }
                If (And (PAM5, 0x30))
                {
                    Store (0x00, E4LN)
                }
                If (And (PAM6, 0x03))
                {
                    Store (0x00, E8LN)
                }
                If (And (PAM6, 0x30))
                {
                    Store (0x00, ECLN)
                }
            }
            Name (SUPP, 0x00)
            Name (CTRL, 0x00)
            Method (_OSC, 4, NotSerialized)
            {
                CreateDWordField (Arg3, 0x00, CDW1)
                CreateDWordField (Arg3, 0x04, CDW2)
                CreateDWordField (Arg3, 0x08, CDW3)
                CreateDWordField (Arg0, 0x00, IID0)
                CreateDWordField (Arg0, 0x04, IID1)
                CreateDWordField (Arg0, 0x08, IID2)
                CreateDWordField (Arg0, 0x0C, IID3)
                Name (UID0, Buffer (0x10)
                {
                    /* 0000 */   0x5B, 0x4D, 0xDB, 0x33, 0xF7, 0x1F, 0x1C, 0x40,
                    /* 0008 */   0x96, 0x57, 0x74, 0x41, 0xC0, 0x3D, 0xD7, 0x66
                })
                CreateDWordField (UID0, 0x00, EID0)
                CreateDWordField (UID0, 0x04, EID1)
                CreateDWordField (UID0, 0x08, EID2)
                CreateDWordField (UID0, 0x0C, EID3)
                If (LAnd (LAnd (LEqual (IID0, EID0), LEqual (IID1, EID1)), LAnd (
                    LEqual (IID2, EID2), LEqual (IID3, EID3))))
                {
                    Store (CDW2, SUPP)
                    Store (CDW3, CTRL)
                    And (CTRL, 0x0D, CTRL)
                    If (LNot (And (CDW1, 0x01)))
                    {
                        If (And (CTRL, 0x01))
                        {
                            If (LNot (\VIGD))
                            {
                                Store (0x00, \_SB.PCI0.PEG.HPGP)
                                Store (0x00, \_SB.PCI0.PEG.GMGP)
                            }
                            Store (0x00, \_SB.PCI0.EXP4.HPCE)
                            Store (0x01, \_SB.PCI0.EXP4.HPCS)
                            Store (0x01, \_SB.PCI0.EXP4.PDC)
                            Store (0x00, \_SB.PCI0.EXP5.HPCE)
                            Store (0x01, \_SB.PCI0.EXP5.HPCS)
                            Store (0x01, \_SB.PCI0.EXP5.PDC)
                            Store (0x01, \NHPS)
                        }
                        If (And (CTRL, 0x04))
                        {
                            If (LNot (\VIGD))
                            {
                                Store (0x00, \_SB.PCI0.PEG.PMGP)
                                Store (0x00, \_SB.PCI0.PEG.GMGP)
                            }
                            If (\_SB.PCI0.EXP1.PMCE)
                            {
                                Store (0x00, \_SB.PCI0.EXP1.PMCE)
                                Store (0x01, \_SB.PCI0.EXP1.PMCS)
                            }
                            If (\_SB.PCI0.EXP2.PMCE)
                            {
                                Store (0x00, \_SB.PCI0.EXP2.PMCE)
                                Store (0x01, \_SB.PCI0.EXP2.PMCS)
                            }
                            If (\_SB.PCI0.EXP4.PMCE)
                            {
                                Store (0x00, \_SB.PCI0.EXP4.PMCE)
                                Store (0x01, \_SB.PCI0.EXP4.PMCS)
                            }
                            If (\_SB.PCI0.EXP5.PMCE)
                            {
                                Store (0x00, \_SB.PCI0.EXP5.PMCE)
                                Store (0x01, \_SB.PCI0.EXP5.PMCS)
                            }
                            If (\_SB.PCI0.EXP7.PMCE)
                            {
                                Store (0x00, \_SB.PCI0.EXP7.PMCE)
                                Store (0x01, \_SB.PCI0.EXP7.PMCS)
                            }
                            Store (0x00, \_SB.PCI0.LPC.EXPE)
                            Store (0x01, \NPME)
                        }
                    }
                    If (LNotEqual (Arg1, 0x01))
                    {
                        Or (CDW1, 0x0A, CDW1)
                    }
                    If (LNotEqual (CDW3, CTRL))
                    {
                        Or (CDW1, 0x10, CDW1)
                    }
                    Store (CTRL, CDW3)
                }
                Else
                {
                    Or (CDW1, 0x06, CDW1)
                }
                Return (Arg3)
            }
            Mutex (MDGS, 0x07)
            Name (VDEE, 0x01)
            Name (VDDA, Buffer (0x02) {})
            CreateBitField (VDDA, 0x00, VUPC)
            CreateBitField (VDDA, 0x01, VQDL)
            CreateBitField (VDDA, 0x02, VQDC)
            CreateBitField (VDDA, 0x03, VQD0)
            CreateBitField (VDDA, 0x04, VQD1)
            CreateBitField (VDDA, 0x05, VQD2)
            CreateBitField (VDDA, 0x06, VSDL)
            CreateBitField (VDDA, 0x07, VSDC)
            CreateBitField (VDDA, 0x08, VSD0)
            CreateBitField (VDDA, 0x09, VSD1)
            CreateBitField (VDDA, 0x0A, VSD2)
            CreateBitField (VDDA, 0x0B, VSD3)
            CreateBitField (VDDA, 0x0C, VSD4)
            CreateBitField (VDDA, 0x0D, VSD5)
            CreateBitField (VDDA, 0x0E, MSWT)
            Device (VID)
            {
                Name (_ADR, 0x00020000)
                Name (RID, 0x00)
                OperationRegion (VPCG, PCI_Config, 0x00, 0x0100)
                Field (VPCG, DWordAcc, NoLock, Preserve)
                {
                    Offset (0xD4), 
                    VPWR,   8
                }
                Name (MIDL, 0x0400)
                Name (MIDC, 0x0100)
                Name (MID0, 0x0300)
                Name (MID1, 0x0301)
                Name (MID2, 0x0302)
                Name (MID3, 0x0303)
                Name (MID4, 0x0304)
                Name (MID5, 0x0305)
                Name (_S3D, 0x03)
                Method (_INI, 0, NotSerialized)
                {
                    Noop
                }
                Method (_PS0, 0, NotSerialized)
                {
                    Noop
                }
                Method (_PS1, 0, NotSerialized)
                {
                    Noop
                }
                Method (_PS2, 0, NotSerialized)
                {
                    Noop
                }
                Method (_PS3, 0, NotSerialized)
                {
                    Noop
                }
                Method (VSWT, 0, NotSerialized)
                {
                    GHDS (0x00)
                }
                Method (VLOC, 1, NotSerialized)
                {
                    If (LEqual (Arg0, \_SB.LID._LID ()))
                    {
                        \VSLD (Arg0)
                        If (LEqual (VPWR, 0x00))
                        {
                            Store (Arg0, CLID)
                            GNOT (0x02, 0x00)
                        }
                    }
                }
                Method (_DOS, 1, NotSerialized)
                {
                    And (Arg0, 0x03, Arg0)
                    If (LEqual (Arg0, 0x02))
                    {
                        Store (0x14, Local0)
                        While (Local0)
                        {
                            Decrement (Local0)
                            Acquire (MDGS, 0xFFFF)
                            If (LEqual (0x00, MSWT))
                            {
                                Store (0x01, MSWT)
                                Store (0x00, Local0)
                                Store (Arg0, VDEE)
                            }
                            Release (MDGS)
                            Sleep (0xC8)
                        }
                    }
                    Else
                    {
                        Acquire (MDGS, 0xFFFF)
                        If (LEqual (VDEE, 0x02))
                        {
                            Store (0x00, MSWT)
                        }
                        If (LGreater (Arg0, 0x02))
                        {
                            Store (0x01, VDEE)
                        }
                        Else
                        {
                            Store (Arg0, VDEE)
                        }
                        Release (MDGS)
                    }
                }
                Method (_DOD, 0, NotSerialized)
                {
                    Store (0x00, NDID)
                    If (LNotEqual (DIDL, 0x00))
                    {
                        Increment (NDID)
                    }
                    If (LNotEqual (DDL2, 0x00))
                    {
                        Increment (NDID)
                    }
                    If (LNotEqual (DDL3, 0x00))
                    {
                        Increment (NDID)
                    }
                    If (LNotEqual (DDL4, 0x00))
                    {
                        Increment (NDID)
                    }
                    If (LNotEqual (DDL5, 0x00))
                    {
                        Increment (NDID)
                    }
                    If (LNotEqual (DDL6, 0x00))
                    {
                        Increment (NDID)
                    }
                    If (LNotEqual (DDL7, 0x00))
                    {
                        Increment (NDID)
                    }
                    If (LNotEqual (DDL8, 0x00))
                    {
                        Increment (NDID)
                    }
                    If (LEqual (NDID, 0x01))
                    {
                        Name (TMP1, Package (0x01)
                        {
                            0xFFFFFFFF
                        })
                        Store (Or (0x80010000, And (0x0F0F, DIDL)), Index (TMP1, 
                            0x00))
                        Return (TMP1)
                    }
                    If (LEqual (NDID, 0x02))
                    {
                        Name (TMP2, Package (0x02)
                        {
                            0xFFFFFFFF, 
                            0xFFFFFFFF
                        })
                        Store (Or (0x80010000, And (0x0F0F, DIDL)), Index (TMP2, 
                            0x00))
                        Store (Or (0x80010000, And (0x0F0F, DDL2)), Index (TMP2, 
                            0x01))
                        Return (TMP2)
                    }
                    If (LEqual (NDID, 0x03))
                    {
                        Name (TMP3, Package (0x03)
                        {
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF
                        })
                        Store (Or (0x80010000, And (0x0F0F, DIDL)), Index (TMP3, 
                            0x00))
                        Store (Or (0x80010000, And (0x0F0F, DDL2)), Index (TMP3, 
                            0x01))
                        Store (Or (0x80010000, And (0x0F0F, DDL3)), Index (TMP3, 
                            0x02))
                        Return (TMP3)
                    }
                    If (LEqual (NDID, 0x04))
                    {
                        Name (TMP4, Package (0x04)
                        {
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF
                        })
                        Store (Or (0x80010000, And (0x0F0F, DIDL)), Index (TMP4, 
                            0x00))
                        Store (Or (0x80010000, And (0x0F0F, DDL2)), Index (TMP4, 
                            0x01))
                        Store (Or (0x80010000, And (0x0F0F, DDL3)), Index (TMP4, 
                            0x02))
                        Store (Or (0x80010000, And (0x0F0F, DDL4)), Index (TMP4, 
                            0x03))
                        Return (TMP4)
                    }
                    If (LEqual (NDID, 0x05))
                    {
                        Name (TMP5, Package (0x05)
                        {
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF
                        })
                        Store (Or (0x80010000, And (0x0F0F, DIDL)), Index (TMP5, 
                            0x00))
                        Store (Or (0x80010000, And (0x0F0F, DDL2)), Index (TMP5, 
                            0x01))
                        Store (Or (0x80010000, And (0x0F0F, DDL3)), Index (TMP5, 
                            0x02))
                        Store (Or (0x80010000, And (0x0F0F, DDL4)), Index (TMP5, 
                            0x03))
                        Store (Or (0x80010000, And (0x0F0F, DDL5)), Index (TMP5, 
                            0x04))
                        Return (TMP5)
                    }
                    If (LEqual (NDID, 0x06))
                    {
                        Name (TMP6, Package (0x06)
                        {
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF
                        })
                        Store (Or (0x80010000, And (0x0F0F, DIDL)), Index (TMP6, 
                            0x00))
                        Store (Or (0x80010000, And (0x0F0F, DDL2)), Index (TMP6, 
                            0x01))
                        Store (Or (0x80010000, And (0x0F0F, DDL3)), Index (TMP6, 
                            0x02))
                        Store (Or (0x80010000, And (0x0F0F, DDL4)), Index (TMP6, 
                            0x03))
                        Store (Or (0x80010000, And (0x0F0F, DDL5)), Index (TMP6, 
                            0x04))
                        Store (Or (0x80010000, And (0x0F0F, DDL6)), Index (TMP6, 
                            0x05))
                        Return (TMP6)
                    }
                    If (LEqual (NDID, 0x07))
                    {
                        Name (TMP7, Package (0x07)
                        {
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF
                        })
                        Store (Or (0x80010000, And (0x0F0F, DIDL)), Index (TMP7, 
                            0x00))
                        Store (Or (0x80010000, And (0x0F0F, DDL2)), Index (TMP7, 
                            0x01))
                        Store (Or (0x80010000, And (0x0F0F, DDL3)), Index (TMP7, 
                            0x02))
                        Store (Or (0x80010000, And (0x0F0F, DDL4)), Index (TMP7, 
                            0x03))
                        Store (Or (0x80010000, And (0x0F0F, DDL5)), Index (TMP7, 
                            0x04))
                        Store (Or (0x80010000, And (0x0F0F, DDL6)), Index (TMP7, 
                            0x05))
                        Store (Or (0x80010000, And (0x0F0F, DDL7)), Index (TMP7, 
                            0x06))
                        Return (TMP7)
                    }
                    If (LGreater (NDID, 0x07))
                    {
                        Name (TMP8, Package (0x08)
                        {
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF
                        })
                        Store (Or (0x80010000, And (0x0F0F, DIDL)), Index (TMP8, 
                            0x00))
                        Store (Or (0x80010000, And (0x0F0F, DDL2)), Index (TMP8, 
                            0x01))
                        Store (Or (0x80010000, And (0x0F0F, DDL3)), Index (TMP8, 
                            0x02))
                        Store (Or (0x80010000, And (0x0F0F, DDL4)), Index (TMP8, 
                            0x03))
                        Store (Or (0x80010000, And (0x0F0F, DDL5)), Index (TMP8, 
                            0x04))
                        Store (Or (0x80010000, And (0x0F0F, DDL6)), Index (TMP8, 
                            0x05))
                        Store (Or (0x80010000, And (0x0F0F, DDL7)), Index (TMP8, 
                            0x06))
                        Store (Or (0x80010000, And (0x0F0F, DDL8)), Index (TMP8, 
                            0x07))
                        Return (TMP8)
                    }
                    Return (Package (0x01)
                    {
                        0x0400
                    })
                }
                Method (VDSW, 1, NotSerialized)
                {
                    If (LEqual (VPWR, 0x00))
                    {
                        GDCK (Arg0)
                    }
                }
                Method (VCAD, 1, NotSerialized)
                {
                    Store (0x00, Local0)
                    If (LEqual (And (DIDL, 0x0F0F), Arg0))
                    {
                        Store (0x0D, Local0)
                    }
                    Else
                    {
                        If (LEqual (And (DDL2, 0x0F0F), Arg0))
                        {
                            Store (0x0D, Local0)
                        }
                        Else
                        {
                            If (LEqual (And (DDL3, 0x0F0F), Arg0))
                            {
                                Store (0x0D, Local0)
                            }
                            Else
                            {
                                If (LEqual (And (DDL4, 0x0F0F), Arg0))
                                {
                                    Store (0x0D, Local0)
                                }
                                Else
                                {
                                    If (LEqual (And (DDL5, 0x0F0F), Arg0))
                                    {
                                        Store (0x0D, Local0)
                                    }
                                    Else
                                    {
                                        If (LEqual (And (DDL6, 0x0F0F), Arg0))
                                        {
                                            Store (0x0D, Local0)
                                        }
                                        Else
                                        {
                                            If (LEqual (And (DDL7, 0x0F0F), Arg0))
                                            {
                                                Store (0x0D, Local0)
                                            }
                                            Else
                                            {
                                                If (LEqual (And (DDL8, 0x0F0F), Arg0))
                                                {
                                                    Store (0x0D, Local0)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    If (LEqual (And (CPDL, 0x0F0F), Arg0))
                    {
                        Or (0x10, Local0, Local0)
                    }
                    Else
                    {
                        If (LEqual (And (CPL2, 0x0F0F), Arg0))
                        {
                            Or (0x10, Local0, Local0)
                        }
                        Else
                        {
                            If (LEqual (And (CPL3, 0x0F0F), Arg0))
                            {
                                Or (0x10, Local0, Local0)
                            }
                            Else
                            {
                                If (LEqual (And (CPL4, 0x0F0F), Arg0))
                                {
                                    Or (0x10, Local0, Local0)
                                }
                                Else
                                {
                                    If (LEqual (And (CPL5, 0x0F0F), Arg0))
                                    {
                                        Or (0x10, Local0, Local0)
                                    }
                                    Else
                                    {
                                        If (LEqual (And (CPL6, 0x0F0F), Arg0))
                                        {
                                            Or (0x10, Local0, Local0)
                                        }
                                        Else
                                        {
                                            If (LEqual (And (CPL7, 0x0F0F), Arg0))
                                            {
                                                Or (0x10, Local0, Local0)
                                            }
                                            Else
                                            {
                                                If (LEqual (And (CPL8, 0x0F0F), Arg0))
                                                {
                                                    Or (0x10, Local0, Local0)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    If (LEqual (And (CADL, 0x0F0F), Arg0))
                    {
                        Or (0x02, Local0, Local0)
                    }
                    Else
                    {
                        If (LEqual (And (CAL2, 0x0F0F), Arg0))
                        {
                            Or (0x02, Local0, Local0)
                        }
                        Else
                        {
                            If (LEqual (And (CAL3, 0x0F0F), Arg0))
                            {
                                Or (0x02, Local0, Local0)
                            }
                            Else
                            {
                                If (LEqual (And (CAL4, 0x0F0F), Arg0))
                                {
                                    Or (0x02, Local0, Local0)
                                }
                                Else
                                {
                                    If (LEqual (And (CAL5, 0x0F0F), Arg0))
                                    {
                                        Or (0x02, Local0, Local0)
                                    }
                                    Else
                                    {
                                        If (LEqual (And (CAL6, 0x0F0F), Arg0))
                                        {
                                            Or (0x02, Local0, Local0)
                                        }
                                        Else
                                        {
                                            If (LEqual (And (CAL7, 0x0F0F), Arg0))
                                            {
                                                Or (0x02, Local0, Local0)
                                            }
                                            Else
                                            {
                                                If (LEqual (And (CAL8, 0x0F0F), Arg0))
                                                {
                                                    Or (0x02, Local0, Local0)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Return (Local0)
                }
                Method (NDDS, 1, NotSerialized)
                {
                    If (LEqual (And (NADL, 0x0F0F), Arg0))
                    {
                        Return (0x01)
                    }
                    Else
                    {
                        If (LEqual (And (NDL2, 0x0F0F), Arg0))
                        {
                            Return (0x01)
                        }
                        Else
                        {
                            If (LEqual (And (NDL3, 0x0F0F), Arg0))
                            {
                                Return (0x01)
                            }
                            Else
                            {
                                If (LEqual (And (NDL4, 0x0F0F), Arg0))
                                {
                                    Return (0x01)
                                }
                                Else
                                {
                                    If (LEqual (And (NDL5, 0x0F0F), Arg0))
                                    {
                                        Return (0x01)
                                    }
                                    Else
                                    {
                                        If (LEqual (And (NDL6, 0x0F0F), Arg0))
                                        {
                                            Return (0x01)
                                        }
                                        Else
                                        {
                                            If (LEqual (And (NDL7, 0x0F0F), Arg0))
                                            {
                                                Return (0x01)
                                            }
                                            Else
                                            {
                                                If (LEqual (And (NDL8, 0x0F0F), Arg0))
                                                {
                                                    Return (0x01)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Return (0x00)
                }
                Device (LCD0)
                {
                    Method (_ADR, 0, NotSerialized)
                    {
                        Return (0x0400)
                    }
                    Method (_DCS, 0, NotSerialized)
                    {
                        Return (VCAD (MIDL))
                    }
                    Method (_DGS, 0, NotSerialized)
                    {
                        Return (NDDS (MIDL))
                    }
                    Method (_DSS, 1, NotSerialized)
                    {
                        And (Arg0, 0x01, VSDL)
                    }
                    Method (_DDC, 1, NotSerialized)
                    {
                        If (LEqual (Arg0, 0x01))
                        {
                            Return (\VEDI)
                        }
                        Else
                        {
                            If (LEqual (Arg0, 0x02))
                            {
                                Return (\VEDI)
                            }
                        }
                        Return (0x00)
                    }
                }
                Device (CRT0)
                {
                    Method (_ADR, 0, NotSerialized)
                    {
                        Return (0x0100)
                    }
                    Method (_DCS, 0, NotSerialized)
                    {
                        Return (VCAD (MIDC))
                    }
                    Method (_DGS, 0, NotSerialized)
                    {
                        Return (NDDS (MIDC))
                    }
                    Method (_DSS, 1, NotSerialized)
                    {
                        And (Arg0, 0x01, VSDC)
                    }
                }
                Device (DVI0)
                {
                    Method (_ADR, 0, NotSerialized)
                    {
                        Return (0x0300)
                    }
                    Method (_DCS, 0, NotSerialized)
                    {
                        Return (VCAD (MID0))
                    }
                    Method (_DGS, 0, NotSerialized)
                    {
                        Return (NDDS (MID0))
                    }
                    Method (_DSS, 1, NotSerialized)
                    {
                        And (Arg0, 0x01, VSD0)
                    }
                }
                Device (DVI1)
                {
                    Method (_ADR, 0, NotSerialized)
                    {
                        Return (0x0301)
                    }
                    Method (_DCS, 0, NotSerialized)
                    {
                        Return (VCAD (MID1))
                    }
                    Method (_DGS, 0, NotSerialized)
                    {
                        Return (NDDS (MID1))
                    }
                    Method (_DSS, 1, NotSerialized)
                    {
                        And (Arg0, 0x01, VSD1)
                    }
                }
                Device (DVI2)
                {
                    Method (_ADR, 0, NotSerialized)
                    {
                        Return (0x0302)
                    }
                    Method (_DCS, 0, NotSerialized)
                    {
                        Return (VCAD (MID2))
                    }
                    Method (_DGS, 0, NotSerialized)
                    {
                        Return (NDDS (MID2))
                    }
                    Method (_DSS, 1, NotSerialized)
                    {
                        And (Arg0, 0x01, VSD2)
                    }
                }
                Device (DVI3)
                {
                    Method (_ADR, 0, NotSerialized)
                    {
                        Return (0x0303)
                    }
                    Method (_DCS, 0, NotSerialized)
                    {
                        Return (VCAD (MID3))
                    }
                    Method (_DGS, 0, NotSerialized)
                    {
                        Return (NDDS (MID3))
                    }
                    Method (_DSS, 1, NotSerialized)
                    {
                        And (Arg0, 0x01, VSD3)
                    }
                }
                Device (DVI4)
                {
                    Method (_ADR, 0, NotSerialized)
                    {
                        Return (0x0304)
                    }
                    Method (_DCS, 0, NotSerialized)
                    {
                        Return (VCAD (MID4))
                    }
                    Method (_DGS, 0, NotSerialized)
                    {
                        Return (NDDS (MID4))
                    }
                    Method (_DSS, 1, NotSerialized)
                    {
                        And (Arg0, 0x01, VSD4)
                    }
                }
                Device (DVI5)
                {
                    Method (_ADR, 0, NotSerialized)
                    {
                        Return (0x0305)
                    }
                    Method (_DCS, 0, NotSerialized)
                    {
                        Return (VCAD (MID5))
                    }
                    Method (_DGS, 0, NotSerialized)
                    {
                        Return (NDDS (MID5))
                    }
                    Method (_DSS, 1, NotSerialized)
                    {
                        And (Arg0, 0x01, VSD5)
                    }
                }
                OperationRegion (IGDP, PCI_Config, 0x40, 0xC0)
                Field (IGDP, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x12), 
                        ,   1, 
                    GIVD,   1, 
                        ,   2, 
                    GUMA,   3, 
                    Offset (0x14), 
                        ,   4, 
                    GMFN,   1, 
                    Offset (0x18), 
                    Offset (0xA4), 
                    ASLE,   8, 
                    Offset (0xA8), 
                    GSSE,   1, 
                    GSSB,   14, 
                    GSES,   1, 
                    Offset (0xB0), 
                        ,   12, 
                    CDVL,   1, 
                    Offset (0xB2), 
                    Offset (0xB5), 
                    LBPC,   8, 
                    Offset (0xBC), 
                    ASLS,   32
                }
                OperationRegion (IGDM, SystemMemory, \ASLB, 0x2000)
                Field (IGDM, AnyAcc, NoLock, Preserve)
                {
                    SIGN,   128, 
                    SIZE,   32, 
                    OVER,   32, 
                    SVER,   256, 
                    VVER,   128, 
                    GVER,   128, 
                    MBOX,   32, 
                    DMOD,   32, 
                    Offset (0x100), 
                    DRDY,   32, 
                    CSTS,   32, 
                    CEVT,   32, 
                    Offset (0x120), 
                    DIDL,   32, 
                    DDL2,   32, 
                    DDL3,   32, 
                    DDL4,   32, 
                    DDL5,   32, 
                    DDL6,   32, 
                    DDL7,   32, 
                    DDL8,   32, 
                    CPDL,   32, 
                    CPL2,   32, 
                    CPL3,   32, 
                    CPL4,   32, 
                    CPL5,   32, 
                    CPL6,   32, 
                    CPL7,   32, 
                    CPL8,   32, 
                    CADL,   32, 
                    CAL2,   32, 
                    CAL3,   32, 
                    CAL4,   32, 
                    CAL5,   32, 
                    CAL6,   32, 
                    CAL7,   32, 
                    CAL8,   32, 
                    NADL,   32, 
                    NDL2,   32, 
                    NDL3,   32, 
                    NDL4,   32, 
                    NDL5,   32, 
                    NDL6,   32, 
                    NDL7,   32, 
                    NDL8,   32, 
                    ASLP,   32, 
                    TIDX,   32, 
                    CHPD,   32, 
                    CLID,   32, 
                    CDCK,   32, 
                    SXSW,   32, 
                    EVTS,   32, 
                    CNOT,   32, 
                    NRDY,   32, 
                    Offset (0x200), 
                    SCIE,   1, 
                    GEFC,   4, 
                    GXFC,   3, 
                    GESF,   8, 
                    Offset (0x204), 
                    PARM,   32, 
                    DSLP,   32, 
                    Offset (0x300), 
                    ARDY,   32, 
                    ASLC,   32, 
                    TCHE,   32, 
                    ALSI,   32, 
                    BCLP,   32, 
                    PFIT,   32, 
                    CBLV,   32, 
                    BCLM,   320, 
                    CPFM,   32, 
                    EPFM,   32, 
                    PLUT,   592, 
                    PFMB,   32, 
                    CCDV,   32, 
                    PCFT,   32, 
                    Offset (0x400), 
                    GVD1,   49152, 
                    PHED,   32, 
                    BDDC,   2048
                }
                Name (DBTB, Package (0x15)
                {
                    0x00, 
                    0x07, 
                    0x38, 
                    0x01C0, 
                    0x0E00, 
                    0x3F, 
                    0x01C7, 
                    0x0E07, 
                    0x01F8, 
                    0x0E38, 
                    0x0FC0, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x00, 
                    0x7000, 
                    0x7007, 
                    0x7038, 
                    0x71C0, 
                    0x7E00
                })
                Name (CDCT, Package (0x05)
                {
                    Package (0x02)
                    {
                        0xE4, 
                        0x0140
                    }, 
                    Package (0x02)
                    {
                        0xDE, 
                        0x014D
                    }, 
                    Package (0x02)
                    {
                        0xDE, 
                        0x014D
                    }, 
                    Package (0x02)
                    {
                        0x00, 
                        0x00
                    }, 
                    Package (0x02)
                    {
                        0xDE, 
                        0x014D
                    }
                })
                Name (SUCC, 0x01)
                Name (NVLD, 0x02)
                Name (CRIT, 0x04)
                Name (NCRT, 0x06)
                Method (GSCI, 0, Serialized)
                {
                    If (LEqual (GEFC, 0x04))
                    {
                        Store (GBDA (), GXFC)
                    }
                    If (LEqual (GEFC, 0x06))
                    {
                        Store (SBCB (), GXFC)
                    }
                    Store (0x00, GEFC)
                    Store (0x01, \_SB.PCI0.LPC.SCIS)
                    Store (0x00, GSSE)
                    Store (0x00, SCIE)
                    Return (Zero)
                }
                Method (GBDA, 0, Serialized)
                {
                    If (LEqual (GESF, 0x00))
                    {
                        Store (0x0241, PARM)
                        Store (Zero, GESF)
                        Return (SUCC)
                    }
                    If (LEqual (GESF, 0x01))
                    {
                        Store (0x0202, PARM)
                        Store (Zero, GESF)
                        Return (SUCC)
                    }
                    If (LEqual (GESF, 0x04))
                    {
                        And (PARM, 0xEFFF0000, PARM)
                        And (PARM, ShiftLeft (DerefOf (Index (DBTB, IBTT)), 0x10), 
                            PARM)
                        Or (IBTT, PARM, PARM)
                        Store (Zero, GESF)
                        Return (SUCC)
                    }
                    If (LEqual (GESF, 0x05))
                    {
                        If (\_SB.LID._LID ())
                        {
                            Store (0x01, LIDS)
                        }
                        Else
                        {
                            Store (0x00, LIDS)
                        }
                        Store (IPSC, PARM)
                        Add (PARM, 0x01, PARM)
                        Add (PARM, 0x0300, PARM)
                        Add (PARM, 0x00010000, PARM)
                        Or (PARM, ShiftLeft (LIDS, 0x10), PARM)
                        Or (PARM, ShiftLeft (IBIA, 0x14), PARM)
                        Store (Zero, GESF)
                        Return (SUCC)
                    }
                    If (LEqual (GESF, 0x06))
                    {
                        Store (ITVF, PARM)
                        Or (PARM, ShiftLeft (ITVM, 0x04), PARM)
                        Store (Zero, GESF)
                        Return (SUCC)
                    }
                    If (LEqual (GESF, 0x07))
                    {
                        Store (GIVD, PARM)
                        XOr (PARM, 0x01, PARM)
                        Or (PARM, ShiftLeft (GMFN, 0x01), PARM)
                        Or (PARM, ShiftLeft (0x03, 0x0B), PARM)
                        Or (PARM, ShiftLeft (0x03, 0x11), PARM)
                        Or (ShiftLeft (DerefOf (Index (DerefOf (Index (CDCT, HVCO)), CDVL
                            )), 0x15), PARM, PARM)
                        Store (0x01, GESF)
                        Return (SUCC)
                    }
                    If (LEqual (GESF, 0x0A))
                    {
                        Store (0x00, PARM)
                        If (ISSC)
                        {
                            Or (PARM, 0x03, PARM)
                        }
                        Store (0x00, GESF)
                        Return (SUCC)
                    }
                    Store (Zero, GESF)
                    Return (CRIT)
                }
                Method (SBCB, 0, Serialized)
                {
                    If (LEqual (GESF, 0x00))
                    {
                        Store (0x0101, PARM)
                        Store (Zero, GESF)
                        Return (SUCC)
                    }
                    If (LEqual (GESF, 0x01))
                    {
                        Store (Zero, GESF)
                        Store (Zero, PARM)
                        Return (SUCC)
                    }
                    If (LEqual (GESF, 0x03))
                    {
                        Store (Zero, GESF)
                        Store (Zero, PARM)
                        Return (SUCC)
                    }
                    If (LEqual (GESF, 0x04))
                    {
                        Store (Zero, GESF)
                        Store (Zero, PARM)
                        Return (SUCC)
                    }
                    If (LEqual (GESF, 0x05))
                    {
                        Store (Zero, GESF)
                        Store (Zero, PARM)
                        Return (SUCC)
                    }
                    If (LEqual (GESF, 0x06))
                    {
                        Store (And (PARM, 0x0F), ITVF)
                        Store (ShiftRight (And (PARM, 0xF0), 0x04), ITVM)
                        Store (Zero, GESF)
                        Store (Zero, PARM)
                        Return (SUCC)
                    }
                    If (LEqual (GESF, 0x07))
                    {
                        Store (Zero, GESF)
                        Store (Zero, PARM)
                        Return (SUCC)
                    }
                    If (LEqual (GESF, 0x08))
                    {
                        Store (Zero, GESF)
                        Store (Zero, PARM)
                        Return (SUCC)
                    }
                    If (LEqual (GESF, 0x09))
                    {
                        And (PARM, 0xFF, IBTT)
                        Store (Zero, GESF)
                        Store (Zero, PARM)
                        Return (SUCC)
                    }
                    If (LEqual (GESF, 0x0A))
                    {
                        And (PARM, 0xFF, IPSC)
                        If (And (ShiftRight (PARM, 0x08), 0xFF))
                        {
                            And (ShiftRight (PARM, 0x08), 0xFF, IPAT)
                            Decrement (IPAT)
                        }
                        And (ShiftRight (PARM, 0x14), 0x07, IBIA)
                        Store (Zero, GESF)
                        Store (Zero, PARM)
                        Return (SUCC)
                    }
                    If (LEqual (GESF, 0x0B))
                    {
                        And (ShiftRight (PARM, 0x01), 0x01, IF1E)
                        If (And (PARM, ShiftLeft (0x0F, 0x0D)))
                        {
                            And (ShiftRight (PARM, 0x0D), 0x0F, IDMS)
                        }
                        Else
                        {
                            And (ShiftRight (PARM, 0x11), 0x0F, IDMS)
                        }
                        Store (Zero, GESF)
                        Store (Zero, PARM)
                        Return (SUCC)
                    }
                    If (LEqual (GESF, 0x10))
                    {
                        Store (Zero, GESF)
                        Store (Zero, PARM)
                        Return (SUCC)
                    }
                    If (LEqual (GESF, 0x11))
                    {
                        Store (ShiftLeft (LIDS, 0x08), PARM)
                        Add (PARM, 0x0100, PARM)
                        Store (Zero, GESF)
                        Return (SUCC)
                    }
                    If (LEqual (GESF, 0x12))
                    {
                        If (And (PARM, 0x01))
                        {
                            If (LEqual (ShiftRight (PARM, 0x01), 0x01))
                            {
                                Store (0x01, ISSC)
                            }
                            Else
                            {
                                Store (Zero, GESF)
                                Return (CRIT)
                            }
                        }
                        Else
                        {
                            Store (0x00, ISSC)
                        }
                        Store (Zero, GESF)
                        Store (Zero, PARM)
                        Return (SUCC)
                    }
                    If (LEqual (GESF, 0x13))
                    {
                        Store (Zero, GESF)
                        Store (Zero, PARM)
                        Return (SUCC)
                    }
                    If (LEqual (GESF, 0x14))
                    {
                        And (PARM, 0x0F, PAVP)
                        Store (Zero, GESF)
                        Store (Zero, PARM)
                        Return (SUCC)
                    }
                    Store (Zero, GESF)
                    Return (SUCC)
                }
                Method (PDRD, 0, NotSerialized)
                {
                    If (LNot (DRDY))
                    {
                        Sleep (ASLP)
                    }
                    Return (LNot (DRDY))
                }
                Method (PSTS, 0, NotSerialized)
                {
                    If (LGreater (CSTS, 0x02))
                    {
                        Sleep (ASLP)
                    }
                    Return (LEqual (CSTS, 0x03))
                }
                Method (GNOT, 2, NotSerialized)
                {
                    If (PDRD ())
                    {
                        Return (0x01)
                    }
                    Store (Arg0, CEVT)
                    Store (0x03, CSTS)
                    If (LAnd (LEqual (CHPD, 0x00), LEqual (Arg1, 0x00)))
                    {
                        If (LNotEqual (Arg0, 0x01))
                        {
                            If (LAnd (\WXPF, LNot (\WVIS)))
                            {
                                Notify (\_SB.PCI0, Arg1)
                            }
                            Else
                            {
                                Notify (\_SB.PCI0.VID, Arg1)
                            }
                        }
                    }
                    Notify (\_SB.PCI0.VID, 0x80)
                    Return (0x00)
                }
                Method (GHDS, 1, NotSerialized)
                {
                    Store (Arg0, TIDX)
                    Return (GNOT (0x01, 0x00))
                }
                Method (GLID, 1, NotSerialized)
                {
                    Store (Arg0, CLID)
                    Return (GNOT (0x02, 0x00))
                }
                Method (GLIS, 1, NotSerialized)
                {
                    Store (Arg0, CLID)
                    Return (0x00)
                }
                Method (GDCK, 1, NotSerialized)
                {
                    Store (Arg0, CDCK)
                    Return (GNOT (0x04, 0x80))
                }
                Method (GDCS, 1, NotSerialized)
                {
                    Store (Arg0, CDCK)
                }
                Method (PARD, 0, NotSerialized)
                {
                    If (LNot (ARDY))
                    {
                        Sleep (ASLP)
                    }
                    Return (LNot (ARDY))
                }
                Method (AINT, 2, NotSerialized)
                {
                    If (LNot (And (TCHE, ShiftLeft (0x01, Arg0))))
                    {
                        Return (0x01)
                    }
                    If (PARD ())
                    {
                        Return (0x01)
                    }
                    If (LEqual (Arg0, 0x02))
                    {
                        XOr (PFIT, 0x07, PFIT)
                        Or (PFIT, 0x80000000, PFIT)
                        Store (0x04, ASLC)
                    }
                    Else
                    {
                        If (LEqual (Arg0, 0x01))
                        {
                            Store (Arg1, BCLP)
                            Or (BCLP, 0x80000000, BCLP)
                            Store (0x0A, ASLC)
                        }
                        Else
                        {
                            If (LEqual (Arg0, 0x03))
                            {
                                Store (Arg1, PFMB)
                                Or (PFMB, 0x80000100, PFMB)
                            }
                            Else
                            {
                                If (LEqual (Arg0, 0x00))
                                {
                                    Store (Arg1, ALSI)
                                    Store (0x01, ASLC)
                                }
                                Else
                                {
                                    Return (0x01)
                                }
                            }
                        }
                    }
                    Store (0x01, ASLE)
                    Return (0x00)
                }
            }
            Device (LPC)
            {
                Name (_ADR, 0x001F0000)
                Name (_S3D, 0x03)
                Name (RID, 0x00)
                Device (SIO)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_UID, 0x00)
                    Name (SCRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0010,             // Range Minimum
                            0x0010,             // Range Maximum
                            0x01,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x0090,             // Range Minimum
                            0x0090,             // Range Maximum
                            0x01,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x0024,             // Range Minimum
                            0x0024,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0028,             // Range Minimum
                            0x0028,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x002C,             // Range Minimum
                            0x002C,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0030,             // Range Minimum
                            0x0030,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0034,             // Range Minimum
                            0x0034,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0038,             // Range Minimum
                            0x0038,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x003C,             // Range Minimum
                            0x003C,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A4,             // Range Minimum
                            0x00A4,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A8,             // Range Minimum
                            0x00A8,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00AC,             // Range Minimum
                            0x00AC,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00B0,             // Range Minimum
                            0x00B0,             // Range Maximum
                            0x01,               // Alignment
                            0x06,               // Length
                            )
                        IO (Decode16,
                            0x00B8,             // Range Minimum
                            0x00B8,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00BC,             // Range Minimum
                            0x00BC,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0050,             // Range Minimum
                            0x0050,             // Range Maximum
                            0x01,               // Alignment
                            0x04,               // Length
                            )
                        IO (Decode16,
                            0x0072,             // Range Minimum
                            0x0072,             // Range Maximum
                            0x01,               // Alignment
                            0x06,               // Length
                            )
                        IO (Decode16,
                            0x0400,             // Range Minimum
                            0x0400,             // Range Maximum
                            0x01,               // Alignment
                            0x80,               // Length
                            )
                        IO (Decode16,
                            0x0500,             // Range Minimum
                            0x0500,             // Range Maximum
                            0x01,               // Alignment
                            0x80,               // Length
                            )
                        IO (Decode16,
                            0x0800,             // Range Minimum
                            0x0800,             // Range Maximum
                            0x01,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x15E0,             // Range Minimum
                            0x15E0,             // Range Maximum
                            0x01,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x1600,             // Range Minimum
                            0x1600,             // Range Maximum
                            0x01,               // Alignment
                            0x80,               // Length
                            )
                        Memory32Fixed (ReadWrite,
                            0xF8000000,         // Address Base
                            0x04000000,         // Address Length
                            )
                        Memory32Fixed (ReadWrite,
                            0x00000000,         // Address Base
                            0x00001000,         // Address Length
                            _Y25)
                        Memory32Fixed (ReadWrite,
                            0xFED1C000,         // Address Base
                            0x00004000,         // Address Length
                            )
                        Memory32Fixed (ReadWrite,
                            0xFED10000,         // Address Base
                            0x00004000,         // Address Length
                            )
                        Memory32Fixed (ReadWrite,
                            0xFED18000,         // Address Base
                            0x00001000,         // Address Length
                            )
                        Memory32Fixed (ReadWrite,
                            0xFED19000,         // Address Base
                            0x00001000,         // Address Length
                            )
                        Memory32Fixed (ReadWrite,
                            0xFED45000,         // Address Base
                            0x00007000,         // Address Length
                            )
                    })
                    CreateDWordField (SCRS, \_SB.PCI0.LPC.SIO._Y25._BAS, TRMB)
                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (\TBAB, TRMB)
                        If (LEqual (\_SB.PCI0.LPC.TPM._STA (), 0x0F))
                        {
                            Return (SCRS)
                        }
                        Else
                        {
                            Subtract (SizeOf (SCRS), 0x02, Local0)
                            Name (BUF0, Buffer (Local0) {})
                            Add (Local0, SizeOf (\_SB.PCI0.LPC.TPM.BUF1), Local0)
                            Name (BUF1, Buffer (Local0) {})
                            Store (SCRS, BUF0)
                            Concatenate (BUF0, \_SB.PCI0.LPC.TPM.BUF1, BUF1)
                            Return (BUF1)
                        }
                    }
                }
                OperationRegion (LPCS, PCI_Config, 0x00, 0x0100)
                Field (LPCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x60), 
                    PIRA,   8, 
                    PIRB,   8, 
                    PIRC,   8, 
                    PIRD,   8, 
                    SERQ,   8, 
                    Offset (0x68), 
                    PIRE,   8, 
                    PIRF,   8, 
                    PIRG,   8, 
                    PIRH,   8, 
                    Offset (0x80), 
                    XU1A,   3, 
                        ,   1, 
                    XU2A,   3, 
                    Offset (0x81), 
                    XPA,    2, 
                        ,   2, 
                    XFA,    1, 
                    Offset (0x82), 
                    XU1E,   1, 
                    XU2E,   1, 
                    XPE,    1, 
                    XFE,    1, 
                    Offset (0x84), 
                    XG1E,   1, 
                        ,   1, 
                    XG1A,   14, 
                    Offset (0x88), 
                    XG2E,   1, 
                        ,   1, 
                    XG2A,   14, 
                    Offset (0xA0), 
                        ,   2, 
                    CLKR,   1, 
                        ,   7, 
                    EXPE,   1, 
                    Offset (0xA2)
                }
                OperationRegion (LPIO, SystemIO, 0x0500, 0x80)
                Field (LPIO, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x0C), 
                        ,   3, 
                    DOI0,   1, 
                    DOI1,   1, 
                    DOI2,   1, 
                    Offset (0x0D), 
                    Offset (0x0E), 
                        ,   6, 
                    GLIS,   1, 
                    Offset (0x0F), 
                    Offset (0x10), 
                    Offset (0x2C), 
                        ,   6, 
                    XHPD,   1, 
                    Offset (0x30), 
                        ,   15, 
                    PCRQ,   1, 
                    Offset (0x34), 
                        ,   15, 
                    PCRS,   1
                }
                OperationRegion (PMIO, SystemIO, 0x0400, 0x80)
                Field (PMIO, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x42), 
                        ,   1, 
                    SWGE,   1, 
                    Offset (0x64), 
                        ,   9, 
                    SCIS,   1, 
                    Offset (0x66)
                }
                OperationRegion (IO_T, SystemIO, 0x0800, 0x10)
                Field (IO_T, ByteAcc, NoLock, Preserve)
                {
                    TRPI,   16, 
                    Offset (0x04), 
                    Offset (0x06), 
                    Offset (0x08), 
                    TRP0,   8, 
                    Offset (0x0A), 
                    Offset (0x0B), 
                    Offset (0x0C), 
                    Offset (0x0D), 
                    Offset (0x0E), 
                    Offset (0x0F), 
                    Offset (0x10)
                }
                Device (PIC)
                {
                    Name (_HID, EisaId ("PNP0000"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0020,             // Range Minimum
                            0x0020,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A0,             // Range Minimum
                            0x00A0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x04D0,             // Range Minimum
                            0x04D0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                    })
                }
                Device (TIMR)
                {
                    Name (_HID, EisaId ("PNP0100"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0040,             // Range Minimum
                            0x0040,             // Range Maximum
                            0x01,               // Alignment
                            0x04,               // Length
                            )
                    })
                }
                Device (HPET)
                {
                    Name (_HID, EisaId ("PNP0103"))
                    Method (_STA, 0, NotSerialized)
                    {
                        If (LAnd (\WNTF, LNot (\WXPF)))
                        {
                            Return (0x00)
                        }
                        Else
                        {
                            Return (0x0F)
                        }
                        Return (0x00)
                    }
                    Name (BUF0, ResourceTemplate ()
                     {
                         IRQNoFlags ()
                             {0}
                         IRQNoFlags ()
                             {8}
                        Memory32Fixed (ReadOnly,
                            0xFED00000,         // Address Base
                            0x00000400,         // Address Length
                            _Y26)
                     })
                    Method (_CRS, 0, Serialized)
                    {
                        CreateDWordField (BUF0, \_SB.PCI0.LPC.HPET._Y26._BAS, HPT0)
                        Store (\HPET, HPT0)
                        Return (BUF0)
                    }
                }
                Device (DMAC)
                {
                    Name (_HID, EisaId ("PNP0200"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x01,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x0080,             // Range Minimum
                            0x0080,             // Range Maximum
                            0x01,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x00C0,             // Range Minimum
                            0x00C0,             // Range Maximum
                            0x01,               // Alignment
                            0x20,               // Length
                            )
                        DMA (Compatibility, BusMaster, Transfer8_16, )
                            {4}
                    })
                }
                Device (SPKR)
                {
                    Name (_HID, EisaId ("PNP0800"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0061,             // Range Minimum
                            0x0061,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                    })
                }
                Device (FPU)
                {
                    Name (_HID, EisaId ("PNP0C04"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x00F0,             // Range Minimum
                            0x00F0,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IRQNoFlags ()
                            {13}
                    })
                }
                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x00,               // Alignment
                            0x02,               // Length
                            )
                    })
                }
                Device (KBD)
                {
                    Name (_HID, EisaId ("PNP0303"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0060,             // Range Minimum
                            0x0060,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0064,             // Range Minimum
                            0x0064,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IRQNoFlags ()
                            {1}
                    })
                }
                Device (MOU)
                {
                    Name (_HID, EisaId ("IBM3780"))
                    Name (_CID, EisaId ("PNP0F13"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IRQNoFlags ()
                            {12}
                    })
                    Method (MHID, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.LPC.PADD)
                        {
                            Store (0x80374D24, _HID)
                        }
                        Else
                        {
                            Store (0x1500AE30, _HID)
                        }
                    }
                }
                OperationRegion (IMGA, SystemIO, 0x15E0, 0x10)
                Field (IMGA, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x01), 
                    Offset (0x02), 
                    Offset (0x03), 
                    WAKR,   16, 
                    Offset (0x0C), 
                    GAIX,   8, 
                    Offset (0x0E), 
                    GADT,   8, 
                    Offset (0x10)
                }
                IndexField (GAIX, GADT, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x50), 
                        ,   3, 
                    IVPW,   1, 
                    DVPW,   1, 
                    BLPL,   1, 
                    Offset (0x51), 
                    TP4R,   1, 
                    PADR,   1, 
                    BPAD,   1, 
                        ,   1, 
                        ,   1, 
                    PADD,   1, 
                    Offset (0x60), 
                    EPWG,   1, 
                        ,   1, 
                    CSON,   1, 
                    DSCI,   1, 
                    DSCS,   1, 
                    DLAN,   1, 
                    Offset (0xC2), 
                    GAID,   8
                }
                Scope (\_SB)
                {
                    Name (TCGP, Buffer (0x08)
                    {
                         0x1F, 0xE0, 0x1F, 0x01, 0x02, 0x04, 0x08, 0xF0
                    })
                    CreateByteField (TCGP, 0x00, PPRQ)
                    CreateByteField (TCGP, 0x01, PPL1)
                    CreateByteField (TCGP, 0x02, PPRP)
                    CreateByteField (TCGP, 0x03, TPRS)
                    CreateByteField (TCGP, 0x04, PPOR)
                    CreateByteField (TCGP, 0x05, TPMV)
                    CreateByteField (TCGP, 0x06, MOR)
                    CreateByteField (TCGP, 0x07, TVEN)
                    OperationRegion (TCGC, SystemIO, 0x72, 0x02)
                    Field (TCGC, ByteAcc, Lock, Preserve)
                    {
                        TIDX,   8, 
                        TPDA,   8
                    }
                    IndexField (TIDX, TPDA, ByteAcc, Lock, Preserve)
                    {
                        Offset (0x40), 
                        TPP1,   8, 
                        PPLO,   8, 
                        TPP3,   8
                    }
                    OperationRegion (SMIP, SystemIO, 0xB2, 0x02)
                    Field (SMIP, WordAcc, NoLock, Preserve)
                    {
                        SMIT,   8, 
                        SMID,   8
                    }
                }
                Device (TPM)
                {
                    Name (TMPV, 0x00)
                    Method (_HID, 0, NotSerialized)
                    {
                        If (LEqual (TVID, 0x15D1))
                        {
                            Return (0x0201D824)
                        }
                        If (LOr (LEqual (TVID, 0x1050), LEqual (TVID, 0x100B)))
                        {
                            Return (0x0010A35C)
                        }
                        If (LEqual (TVID, 0x19FA))
                        {
                            Return (0x0435CF4D)
                        }
                        If (LEqual (TDID, 0x1002))
                        {
                            Return (0x02016D08)
                        }
                        If (LEqual (TDID, 0x1001))
                        {
                            Return (0x01016D08)
                        }
                        If (LEqual (TVID, 0x1114))
                        {
                            Return (0x00128D06)
                        }
                        If (LEqual (TVID, 0x104A))
                        {
                            Return (0x0012AF4D)
                        }
                        Return (0x310CD041)
                    }
                    Name (_CID, EisaId ("PNP0C31"))
                    Name (_UID, 0x01)
                    OperationRegion (TMMB, SystemMemory, 0xFED40000, 0x1000)
                    Field (TMMB, ByteAcc, Lock, Preserve)
                    {
                        ACCS,   8, 
                        Offset (0x18), 
                        TSTA,   8, 
                        TBCA,   8, 
                        Offset (0xF00), 
                        TVID,   16, 
                        TDID,   16
                    }
                    Method (_STA, 0, NotSerialized)
                    {
                        If (LEqual (ACCS, 0xFF))
                        {
                            Return (0x00)
                        }
                        Else
                        {
                            If (LEqual (TPME, 0x00))
                            {
                                Return (0x00)
                            }
                        }
                        Return (0x0F)
                    }
                    Name (BUF1, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly,
                            0xFED40000,         // Address Base
                            0x00005000,         // Address Length
                            )
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Return (BUF1)
                    }
                    Method (UCMP, 2, NotSerialized)
                    {
                        If (LNotEqual (0x10, SizeOf (Arg0)))
                        {
                            Return (0x00)
                        }
                        If (LNotEqual (0x10, SizeOf (Arg1)))
                        {
                            Return (0x00)
                        }
                        Store (0x00, Local0)
                        While (LLess (Local0, 0x10))
                        {
                            If (LNotEqual (DerefOf (Index (Arg0, Local0)), DerefOf (Index (
                                Arg1, Local0))))
                            {
                                Return (0x00)
                            }
                            Increment (Local0)
                        }
                        Return (0x01)
                    }
                    Method (_DSM, 4, Serialized)
                    {
                        Name (TTMP, Buffer (0x01)
                        {
                             0x00
                        })
                        CreateByteField (TTMP, 0x00, TMPV)
                        If (LEqual (UCMP (Arg0, Buffer (0x10)
                                    {
                                        /* 0000 */   0xA6, 0xFA, 0xDD, 0x3D, 0x1B, 0x36, 0xB4, 0x4E,
                                        /* 0008 */   0xA4, 0x24, 0x8D, 0x10, 0x08, 0x9D, 0x16, 0x53
                                    }), 0x01))
                        {
                            If (LEqual (Arg2, 0x00))
                            {
                                Return (Buffer (0x01)
                                {
                                     0x7F
                                })
                            }
                            If (LEqual (Arg2, 0x01))
                            {
                                Return (Buffer (0x04)
                                {
                                    "1.0"
                                })
                            }
                            If (LEqual (Arg2, 0x02))
                            {
                                If (TPRS)
                                {
                                    If (LOr (LLessEqual (DerefOf (Index (Arg3, 0x00)), 0x0B), 
                                        LEqual (DerefOf (Index (Arg3, 0x00)), 0x0E)))
                                    {
                                        Store (DerefOf (Index (Arg3, 0x00)), SMID)
                                        Store (0xC1, SMIT)
                                        Store (DerefOf (Index (Arg3, 0x00)), TPP1)
                                        Return (0x00)
                                    }
                                    Return (0x01)
                                }
                                Return (0x01)
                            }
                            If (LEqual (Arg2, 0x03))
                            {
                                Name (TMP1, Package (0x02)
                                {
                                    0x00, 
                                    0xFFFFFFFF
                                })
                                Store (TPP1, TMPV)
                                Store (And (TMPV, PPRQ, TMPV), Index (TMP1, 0x01))
                                Return (TMP1)
                            }
                            If (LEqual (Arg2, 0x04))
                            {
                                Return (0x01)
                            }
                            If (LEqual (Arg2, 0x05))
                            {
                                Name (TMP2, Package (0x03)
                                {
                                    0x00, 
                                    0xFFFFFFFF, 
                                    0xFFFFFFFF
                                })
                                Store (\_SB.PPLO, Index (TMP2, 0x01))
                                If (LOr (LOr (LGreater (\_SB.PPLO, 0x0E), LEqual (\_SB.PPLO, 0x0C)), LEqual (
                                    \_SB.PPLO, 0x0D)))
                                {
                                    Store (0xFFFFFFF1, Index (TMP2, 0x02))
                                    Return (TMP2)
                                }
                                If (LEqual (PPRQ, 0xFF))
                                {
                                    Store (0xFFFFFFF1, Index (TMP2, 0x02))
                                    Return (TMP2)
                                }
                                If (And (TPP3, 0x02))
                                {
                                    Store (0xFFFFFFF0, Index (TMP2, 0x02))
                                    Return (TMP2)
                                }
                                Store (0x00, Index (TMP2, 0x02))
                                Return (TMP2)
                            }
                            If (LEqual (Arg2, 0x06))
                            {
                                CreateByteField (Arg3, 0x04, LAN0)
                                CreateByteField (Arg3, 0x05, LAN1)
                                If (LOr (LEqual (LAN0, 0x65), LEqual (LAN0, 0x45)))
                                {
                                    If (LOr (LEqual (LAN1, 0x6E), LEqual (LAN1, 0x4E)))
                                    {
                                        Return (0x00)
                                    }
                                }
                                Return (0x01)
                            }
                            Return (0x01)
                        }
                        If (LEqual (UCMP (Arg0, Buffer (0x10)
                                    {
                                        /* 0000 */   0xED, 0x54, 0x60, 0x37, 0x13, 0xCC, 0x75, 0x46,
                                        /* 0008 */   0x90, 0x1C, 0x47, 0x56, 0xD7, 0xF2, 0xD4, 0x5D
                                    }), 0x01))
                        {
                            If (LEqual (Arg2, 0x00))
                            {
                                Return (Buffer (0x01)
                                {
                                     0x01
                                })
                            }
                            If (LEqual (Arg2, 0x01))
                            {
                                If (LEqual (DerefOf (Index (Arg3, 0x00)), 0x00))
                                {
                                    Store (0x00, MORD)
                                    Store (0x80, SMID)
                                    Store (0xC1, SMIT)
                                    Return (0x00)
                                }
                                If (LEqual (DerefOf (Index (Arg3, 0x00)), 0x01))
                                {
                                    Store (0x01, MORD)
                                    Store (0x81, SMID)
                                    Store (0xC1, SMIT)
                                    Return (0x00)
                                }
                            }
                            Return (0x01)
                        }
                        Return (Buffer (0x01)
                        {
                             0x00
                        })
                    }
                    Method (CMOR, 0, NotSerialized)
                    {
                        Store (0x00, MORD)
                        Store (0x80, SMID)
                        Store (0xC1, SMIT)
                    }
                }
                Device (SMCD)
                {
                    Name (_HID, "MONITOR")
                    Method (FAN0, 0, NotSerialized)
                    {
                        Store (^^EC.HFN1, Local0)
                        Return (Local0)
                    }
                    Method (TCPU, 0, NotSerialized)
                    {
                        Store (^^EC.TMP0, Local0)
                        Return (Local0)
                    }
                }
                Device (EC)
                {
                    Name (_HID, EisaId ("PNP0C09"))
                    Name (_UID, 0x00)
                    Name (_GPE, 0x11)
                    Method (_REG, 2, NotSerialized)
                    {
                        If (LEqual (Arg0, 0x03))
                        {
                            Store (Arg1, \H8DR)
                        }
                    }
                    OperationRegion (ECOR, EmbeddedControl, 0x00, 0x0100)
                    Field (ECOR, ByteAcc, NoLock, Preserve)
                    {
                        HDBM,   1, 
                            ,   1, 
                            ,   1, 
                        HFNE,   1, 
                            ,   1, 
                            ,   1, 
                        HLDM,   1, 
                        Offset (0x01), 
                        BBLS,   1, 
                        BTCM,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        HBPR,   1, 
                        BTPC,   1, 
                        Offset (0x02), 
                        HDUE,   1, 
                            ,   4, 
                        SNLK,   1, 
                        Offset (0x03), 
                            ,   5, 
                        HAUM,   2, 
                        Offset (0x05), 
                        HSPA,   1, 
                        Offset (0x06), 
                        HSUN,   8, 
                        HSRP,   8, 
                        Offset (0x0C), 
                        HLCL,   8, 
                            ,   4, 
                        CALM,   1, 
                        Offset (0x0E), 
                        HFNS,   2, 
                        Offset (0x0F), 
                            ,   6, 
                        NULS,   1, 
                        Offset (0x10), 
                        HAM0,   8, 
                        HAM1,   8, 
                        HAM2,   8, 
                        HAM3,   8, 
                        HAM4,   8, 
                        HAM5,   8, 
                        HAM6,   8, 
                        HAM7,   8, 
                        HAM8,   8, 
                        HAM9,   8, 
                        HAMA,   8, 
                        HAMB,   8, 
                        HAMC,   8, 
                        HAMD,   8, 
                        HAME,   8, 
                        HAMF,   8, 
                        Offset (0x23), 
                        HANT,   8, 
                        Offset (0x26), 
                            ,   2, 
                        HANA,   2, 
                        Offset (0x27), 
                        Offset (0x2A), 
                        HATR,   8, 
                        HT0H,   8, 
                        HT0L,   8, 
                        HT1H,   8, 
                        HT1L,   8, 
                        HFSP,   8, 
                            ,   6, 
                        HMUT,   1, 
                        Offset (0x31), 
                            ,   2, 
                        HUWB,   1, 
                        Offset (0x32), 
                        HWPM,   1, 
                        HWLB,   1, 
                        HWLO,   1, 
                        HWDK,   1, 
                        HWFN,   1, 
                        HWBT,   1, 
                        HWRI,   1, 
                        HWBU,   1, 
                        HWLU,   1, 
                        Offset (0x34), 
                            ,   3, 
                        PIBS,   1, 
                            ,   3, 
                        HPLO,   1, 
                        Offset (0x36), 
                        Offset (0x38), 
                        HB0S,   7, 
                        HB0A,   1, 
                        HB1S,   7, 
                        HB1A,   1, 
                        HCMU,   1, 
                            ,   2, 
                        OVRQ,   1, 
                        DCBD,   1, 
                        DCWL,   1, 
                        DCWW,   1, 
                        HB1I,   1, 
                            ,   1, 
                        KBLT,   1, 
                        BTPW,   1, 
                        BTDT,   1, 
                        HUBS,   1, 
                        BDPW,   1, 
                        BDDT,   1, 
                        HUBB,   1, 
                        Offset (0x46), 
                            ,   1, 
                        BTWK,   1, 
                        HPLD,   1, 
                            ,   1, 
                        HPAC,   1, 
                        BTST,   1, 
                        Offset (0x47), 
                        HPBU,   1, 
                            ,   1, 
                        HBID,   1, 
                            ,   3, 
                        HBCS,   1, 
                        HPNF,   1, 
                            ,   1, 
                        GSTS,   1, 
                            ,   2, 
                        HLBU,   1, 
                        DOCD,   1, 
                        HCBL,   1, 
                        Offset (0x49), 
                        SLUL,   1, 
                        Offset (0x4C), 
                        HTMH,   8, 
                        HTML,   8, 
                        HWAK,   16, 
                        HMPR,   8, 
                            ,   7, 
                        HMDN,   1, 
                        Offset (0x78), 
                        TMP0,   8, 
                        Offset (0x80), 
                        Offset (0x81), 
                        HIID,   8, 
                        Offset (0x83), 
                        HFNI,   8, 
                        HSPD,   16, 
                        Offset (0x88), 
                        TSL0,   7, 
                        TSR0,   1, 
                        TSL1,   7, 
                        TSR1,   1, 
                        TSL2,   7, 
                        TSR2,   1, 
                        TSL3,   7, 
                        TSR3,   1, 
                        Offset (0x8D), 
                        HDAA,   3, 
                        HDAB,   3, 
                        HDAC,   2, 
                        Offset (0xB0), 
                        HDEN,   32, 
                        HDEP,   32, 
                        HDEM,   8, 
                        HDES,   8, 
                        Offset (0xBB), 
                        PLSL,   8, 
                        PLMS,   8, 
                        PLLS,   8, 
                        PLTU,   8, 
                        Offset (0xC8), 
                        ATMX,   8, 
                        HWAT,   8, 
                        Offset (0xCC), 
                        PWMH,   8, 
                        PWML,   8, 
                        Offset (0xED), 
                            ,   4, 
                        HDDD,   1, 
                        Offset (0xFF), 
                        FQ5B,   1, 
                            ,   4, 
                        OCPF,   1, 
                        P7FG,   1, 
                        VTAF,   1
                    }
                    Field (ECOR, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x84), 
                        HFN1,   16
                    }
                    Method (_INI, 0, NotSerialized)
                    {
                        If (\H8DR)
                        {
                            Store (0x00, HSPA)
                        }
                        Else
                        {
                            \MBEC (0x05, 0xFE, 0x00)
                        }
                        BINI ()
                        \_SB.PCI0.LPC.EC.HKEY.WGIN ()
                    }
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0062,             // Range Minimum
                            0x0062,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0066,             // Range Minimum
                            0x0066,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                    })
                    Method (LED, 2, NotSerialized)
                    {
                        Or (Arg0, Arg1, Local0)
                        If (\H8DR)
                        {
                            Store (Local0, HLCL)
                        }
                        Else
                        {
                            \WBEC (0x0C, Local0)
                        }
                    }
                    Name (BAON, 0x00)
                    Name (WBON, 0x00)
                    Method (BEEP, 1, NotSerialized)
                    {
                        If (LEqual (Arg0, 0x05))
                        {
                            Store (0x00, WBON)
                        }
                        Store (WBON, Local2)
                        If (BAON)
                        {
                            If (LEqual (Arg0, 0x00))
                            {
                                Store (0x00, BAON)
                                If (WBON)
                                {
                                    Store (0x03, Local0)
                                    Store (0x08, Local1)
                                }
                                Else
                                {
                                    Store (0x00, Local0)
                                    Store (0x00, Local1)
                                }
                            }
                            Else
                            {
                                Store (0xFF, Local0)
                                Store (0xFF, Local1)
                                If (LEqual (Arg0, 0x11))
                                {
                                    Store (0x00, WBON)
                                }
                                If (LEqual (Arg0, 0x10))
                                {
                                    Store (0x01, WBON)
                                }
                            }
                        }
                        Else
                        {
                            Store (Arg0, Local0)
                            Store (0xFF, Local1)
                            If (LEqual (Arg0, 0x0F))
                            {
                                Store (Arg0, Local0)
                                Store (0x08, Local1)
                                Store (0x01, BAON)
                            }
                            If (LEqual (Arg0, 0x11))
                            {
                                Store (0x00, Local0)
                                Store (0x00, Local1)
                                Store (0x00, WBON)
                            }
                            If (LEqual (Arg0, 0x10))
                            {
                                Store (0x03, Local0)
                                Store (0x08, Local1)
                                Store (0x01, WBON)
                            }
                        }
                        If (LEqual (Arg0, 0x03))
                        {
                            Store (0x00, WBON)
                            If (Local2)
                            {
                                Store (0x07, Local0)
                                If (LOr (LEqual (\SPS, 0x03), LEqual (\SPS, 0x04)))
                                {
                                    Store (0x00, Local2)
                                    Store (0xFF, Local0)
                                    Store (0xFF, Local1)
                                }
                            }
                        }
                        If (LEqual (Arg0, 0x07))
                        {
                            If (Local2)
                            {
                                Store (0x00, Local2)
                                Store (0xFF, Local0)
                                Store (0xFF, Local1)
                            }
                        }
                        If (\H8DR)
                        {
                            If (LAnd (Local2, LNot (WBON)))
                            {
                                Store (0x00, HSRP)
                                Store (0x00, HSUN)
                                Sleep (0x64)
                            }
                            If (LNotEqual (Local1, 0xFF))
                            {
                                Store (Local1, HSRP)
                            }
                            If (LNotEqual (Local0, 0xFF))
                            {
                                Store (Local0, HSUN)
                            }
                        }
                        Else
                        {
                            If (LAnd (Local2, LNot (WBON)))
                            {
                                \WBEC (0x07, 0x00)
                                \WBEC (0x06, 0x00)
                                Sleep (0x64)
                            }
                            If (LNotEqual (Local1, 0xFF))
                            {
                                \WBEC (0x07, Local1)
                            }
                            If (LNotEqual (Local0, 0xFF))
                            {
                                \WBEC (0x06, Local0)
                            }
                        }
                        If (LEqual (Arg0, 0x03)) {}
                        If (LEqual (Arg0, 0x07))
                        {
                            Sleep (0x01F4)
                        }
                    }
                    Method (EVNT, 1, NotSerialized)
                    {
                        If (\H8DR)
                        {
                            If (Arg0)
                            {
                                Or (HAM7, 0x01, HAM7)
                                Or (HAM5, 0x04, HAM5)
                            }
                            Else
                            {
                                And (HAM7, 0xFE, HAM7)
                                And (HAM5, 0xFB, HAM5)
                            }
                        }
                        Else
                        {
                            If (Arg0)
                            {
                                \MBEC (0x17, 0xFF, 0x01)
                                \MBEC (0x15, 0xFF, 0x04)
                            }
                            Else
                            {
                                \MBEC (0x17, 0xFE, 0x00)
                                \MBEC (0x15, 0xFB, 0x00)
                            }
                        }
                    }
                    PowerResource (PUBS, 0x03, 0x0000)
                    {
                        Method (_STA, 0, NotSerialized)
                        {
                            If (\H8DR)
                            {
                                Store (HUBS, Local0)
                            }
                            Else
                            {
                                And (\RBEC (0x3B), 0x10, Local0)
                            }
                            If (Local0)
                            {
                                Return (0x01)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }
                        Method (_ON, 0, NotSerialized)
                        {
                            If (\H8DR)
                            {
                                Store (0x01, HUBS)
                            }
                            Else
                            {
                                \MBEC (0x3B, 0xFF, 0x10)
                            }
                        }
                        Method (_OFF, 0, NotSerialized)
                        {
                            If (\H8DR)
                            {
                                Store (0x00, HUBS)
                            }
                            Else
                            {
                                \MBEC (0x3B, 0xEF, 0x00)
                            }
                        }
                    }
                    Method (CHKS, 0, NotSerialized)
                    {
                        Store (0x03E8, Local0)
                        While (HMPR)
                        {
                            Sleep (0x01)
                            Decrement (Local0)
                            If (LNot (Local0))
                            {
                                Return (0x8080)
                            }
                        }
                        If (HMDN)
                        {
                            Return (Zero)
                        }
                        Return (0x8081)
                    }
                    Method (LPMD, 0, NotSerialized)
                    {
                        Store (0x00, Local0)
                        Store (0x00, Local1)
                        Store (0x00, Local2)
                        If (\H8DR)
                        {
                            If (HPAC)
                            {
                                If (LAnd (HPLO, \PCWF))
                                {
                                    Store (\LPST, Local0)
                                }
                                Else
                                {
                                    If (LLess (HWAT, 0xAA))
                                    {
                                        If (HB0A)
                                        {
                                            If (LOr (And (HB0S, 0x10), LLess (And (HB0S, 0x0F
                                                ), 0x02)))
                                            {
                                                Store (0x01, Local1)
                                            }
                                        }
                                        Else
                                        {
                                            Store (0x01, Local1)
                                        }
                                        If (HB1A)
                                        {
                                            If (LOr (And (HB1S, 0x10), LLess (And (HB1S, 0x0F
                                                ), 0x02)))
                                            {
                                                Store (0x01, Local2)
                                            }
                                        }
                                        Else
                                        {
                                            Store (0x01, Local2)
                                        }
                                        If (LAnd (Local1, Local2))
                                        {
                                            Store (\LPST, Local0)
                                        }
                                    }
                                }
                            }
                        }
                        Else
                        {
                            If (And (\RBEC (0x46), 0x10))
                            {
                                If (And (\RBEC (0x34), 0x80))
                                {
                                    Store (\LPST, Local0)
                                }
                                Else
                                {
                                    If (LLess (\RBEC (0xC9), 0xAA))
                                    {
                                        Store (\RBEC (0x38), Local3)
                                        If (And (Local3, 0x80))
                                        {
                                            If (LOr (And (Local3, 0x10), LLess (And (Local3, 0x0F
                                                ), 0x02)))
                                            {
                                                Store (0x01, Local1)
                                            }
                                        }
                                        Else
                                        {
                                            Store (0x01, Local2)
                                        }
                                        Store (\RBEC (0x39), Local3)
                                        If (And (Local3, 0x80))
                                        {
                                            If (LOr (And (Local3, 0x10), LLess (And (Local3, 0x0F
                                                ), 0x02)))
                                            {
                                                Store (0x01, Local1)
                                            }
                                        }
                                        Else
                                        {
                                            Store (0x01, Local2)
                                        }
                                        If (LAnd (Local1, Local2))
                                        {
                                            Store (\LPST, Local0)
                                        }
                                    }
                                }
                            }
                        }
                        Return (Local0)
                    }
                    Method (CLPM, 0, NotSerialized)
                    {
                        If (And (\PPMF, 0x01))
                        {
                            If (\OSPX)
                            {
                                \PNTF (0x80)
                            }
                            Else
                            {
                                Store (LPMD (), Local0)
                                If (Local0)
                                {
                                    \STEP (0x04)
                                }
                                Else
                                {
                                    \STEP (0x05)
                                }
                            }
                        }
                    }
                    Mutex (MCPU, 0x07)
                    Method (_Q10, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.LPC.EC.HKEY.MHKK (0x01))
                        {
                            \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x1001)
                        }
                    }
                    Method (_Q11, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.LPC.EC.HKEY.MHKK (0x02))
                        {
                            \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x1002)
                        }
                        Else
                        {
                            Noop
                        }
                    }
                    Method (_Q12, 0, NotSerialized)
                    {
                        \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x1003)
                    }
                    Method (_Q13, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.LPC.EC.HKEY.DHKC)
                        {
                            \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x1004)
                        }
                        Else
                        {
                            Notify (\_SB.SLPB, 0x80)
                        }
                    }
                    Method (_Q64, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.LPC.EC.HKEY.MHKK (0x10))
                        {
                            \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x1005)
                        }
                    }
                    Method (_Q65, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.LPC.EC.HKEY.MHKK (0x20))
                        {
                            \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x1006)
                        }
                    }
                    Method (_Q16, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.LPC.EC.HKEY.MHKK (0x40))
                        {
                            \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x1007)
                        }
                        Else
                        {
                            If (LEqual (\VHYB (0x03, 0x00), 0x03))
                            {
                                Notify (\_SB.PCI0.VID, 0x80)
                                Return (Zero)
                            }
                            If (VIGD)
                            {
                                \_SB.PCI0.VID.VSWT ()
                            }
                            Else
                            {
                                \_SB.PCI0.PEG.VID.VSWT ()
                            }
                        }
                    }
                    Method (_Q17, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.LPC.EC.HKEY.MHKK (0x80))
                        {
                            \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x1008)
                        }
                        Else
                        {
                            If (LNot (\WNTF))
                            {
                                VEXP ()
                            }
                        }
                    }
                    Method (_Q18, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.LPC.EC.HKEY.MHKK (0x0100))
                        {
                            \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x1009)
                        }
                        Noop
                    }
                    Method (_Q66, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.LPC.EC.HKEY.MHKK (0x0200))
                        {
                            \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x100A)
                        }
                    }
                    Method (_Q1A, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.LPC.EC.HKEY.MHKK (0x0400))
                        {
                            \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x100B)
                        }
                    }
                    Method (_Q1B, 0, NotSerialized)
                    {
                        \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x100C)
                    }
                    Method (_Q62, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.LPC.EC.HKEY.MHKK (0x1000))
                        {
                            \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x100D)
                        }
                    }
                    Method (_Q60, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.LPC.EC.HKEY.MHKK (0x2000))
                        {
                            \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x100E)
                        }
                    }
                    Method (_Q61, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.LPC.EC.HKEY.MHKK (0x4000))
                        {
                            \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x100F)
                        }
                    }
                    Method (_Q1F, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.LPC.EC.HKEY.MHKK (0x00020000))
                        {
                            \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x1012)
                        }
                        \UCMS (0x0E)
                    }
                    Method (_Q67, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.LPC.EC.HKEY.MHKK (0x00040000))
                        {
                            \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x1013)
                        }
                    }
                    Method (_Q1C, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.LPC.EC.HKEY.MHKK (0x01000000))
                        {
                            \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x1019)
                        }
                    }
                    Method (_Q1D, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.LPC.EC.HKEY.MHKK (0x02000000))
                        {
                            \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x101A)
                        }
                    }
                    Method (_Q26, 0, NotSerialized)
                    {
                        If (VIGD)
                        {
                            If (\WVIS)
                            {
                                \VBTD ()
                            }
                            \_SB.PCI0.LPC.EC.BRNS ()
                        }
                        Else
                        {
                            \UCMS (0x12)
                        }
                        If (\_SB.PCI0.PEG.VID.ISOP ())
                        {
                            Notify (\_SB.PCI0.PEG.VID, 0xDF)
                        }
                        Sleep (0x01F4)
                        Notify (AC, 0x80)
                        Notify (\_TZ.THM0, 0x80)
                        If (\WXPF)
                        {
                            Acquire (MCPU, 0xFFFF)
                        }
                        Store (0x01, PWRS)
                        If (And (\PPMF, 0x01))
                        {
                            If (\OSPX)
                            {
                                \PNTF (0x80)
                            }
                        }
                        If (\WXPF)
                        {
                            Sleep (0x64)
                        }
                        If (\OSC4)
                        {
                            \PNTF (0x81)
                        }
                        If (\WXPF)
                        {
                            Release (MCPU)
                        }
                        \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x6040)
                        ATMC ()
                    }
                    Method (_Q27, 0, NotSerialized)
                    {
                        If (VIGD)
                        {
                            If (\WVIS)
                            {
                                \VBTD ()
                            }
                            \_SB.PCI0.LPC.EC.BRNS ()
                        }
                        Else
                        {
                            \UCMS (0x12)
                        }
                        If (\_SB.PCI0.PEG.VID.ISOP ())
                        {
                            Notify (\_SB.PCI0.PEG.VID, 0xDF)
                        }
                        Sleep (0x01F4)
                        Notify (AC, 0x80)
                        Notify (\_TZ.THM0, 0x80)
                        If (\WXPF)
                        {
                            Acquire (MCPU, 0xFFFF)
                        }
                        Store (0x00, PWRS)
                        If (And (\PPMF, 0x01))
                        {
                            If (\OSPX)
                            {
                                \PNTF (0x80)
                            }
                        }
                        If (\WXPF)
                        {
                            Sleep (0x64)
                        }
                        If (\OSC4)
                        {
                            \PNTF (0x81)
                        }
                        If (\WXPF)
                        {
                            Release (MCPU)
                        }
                        \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x6040)
                        ATMC ()
                    }
                    Method (_Q5B, 0, NotSerialized)
                    {
                        If (\OSPX)
                        {
                            \PNTF (0x80)
                        }
                        Else
                        {
                            \STEP (0x04)
                        }
                        Store (0x01, \_SB.PCI0.LPC.EC.FQ5B)
                    }
                    Method (_Q2A, 0, NotSerialized)
                    {
                        \VCMS (0x01, \_SB.LID._LID ())
                        If (LEqual (\ILNF, 0x00))
                        {
                            \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x5002)
                            If (LEqual (\PLUX, 0x00))
                            {
                                If (VIGD)
                                {
                                    \_SB.PCI0.VID.GLIS (0x01)
                                    \_SB.PCI0.VID.VLOC (0x01)
                                }
                                Else
                                {
                                    \_SB.PCI0.PEG.VID.VLOC (0x01)
                                }
                                Notify (\_SB.LID, 0x80)
                            }
                        }
                    }
                    Method (_Q2B, 0, NotSerialized)
                    {
                        \UCMS (0x0D)
                        \VCMS (0x01, \_SB.LID._LID ())
                        If (LEqual (\ILNF, 0x00))
                        {
                            \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x5001)
                            If (LEqual (\PLUX, 0x00))
                            {
                                If (VIGD)
                                {
                                    \_SB.PCI0.VID.GLIS (0x00)
                                }
                                Else
                                {
                                    \_SB.PCI0.PEG.VID.VLOC (0x00)
                                }
                                Notify (\_SB.LID, 0x80)
                            }
                        }
                    }
                    Method (_Q3D, 0, NotSerialized)
                    {
                    }
                    Method (_Q48, 0, NotSerialized)
                    {
                        Store (0x01, \PCWF)
                        If (And (\PPMF, 0x01))
                        {
                            If (\OSPX)
                            {
                                \PNTF (0x80)
                            }
                            Else
                            {
                                \STEP (0x04)
                            }
                            Store (0x01, \_SB.PCI0.LPC.EC.CALM)
                        }
                    }
                    Method (_Q49, 0, NotSerialized)
                    {
                        If (And (\PPMF, 0x01))
                        {
                            If (\OSPX)
                            {
                                \PNTF (0x80)
                            }
                            Else
                            {
                                \STEP (0x05)
                            }
                        }
                    }
                    Method (_Q7F, 0, NotSerialized)
                    {
                        Fatal (0x01, 0x80010000, 0x029F)
                    }
                    Method (_Q4E, 0, NotSerialized)
                    {
                        \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x6011)
                    }
                    Method (_Q4F, 0, NotSerialized)
                    {
                        \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x6012)
                    }
                    Method (_Q46, 0, NotSerialized)
                    {
                        \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x6012)
                    }
                    Method (_Q22, 0, NotSerialized)
                    {
                        CLPM ()
                        If (HB0A)
                        {
                            Notify (BAT0, 0x80)
                        }
                        If (HB1A)
                        {
                            Notify (BAT1, 0x80)
                        }
                    }
                    Method (_Q4A, 0, NotSerialized)
                    {
                        CLPM ()
                        Notify (BAT0, 0x81)
                    }
                    Method (_Q4B, 0, NotSerialized)
                    {
                        Notify (BAT0, 0x80)
                    }
                    Method (_Q4C, 0, NotSerialized)
                    {
                        CLPM ()
                        If (HB1A)
                        {
                            \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x4010)
                        }
                        Else
                        {
                            \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x4011)
                            If (^BAT1.XB1S)
                            {
                                Notify (\_SB.PCI0.LPC.EC.BAT1, 0x03)
                            }
                        }
                    }
                    Method (_Q4D, 0, NotSerialized)
                    {
                        If (LEqual (^BAT1.SBLI, 0x01))
                        {
                            Sleep (0x0A)
                            If (LAnd (HB1A, LEqual (SLUL, 0x00)))
                            {
                                Store (0x01, ^BAT1.XB1S)
                                Notify (\_SB.PCI0.LPC.EC.BAT1, 0x01)
                            }
                        }
                        Else
                        {
                            If (LEqual (SLUL, 0x01))
                            {
                                Store (0x00, ^BAT1.XB1S)
                                Notify (\_SB.PCI0.LPC.EC.BAT1, 0x03)
                            }
                        }
                        If (And (^BAT1.B1ST, ^BAT1.XB1S))
                        {
                            Notify (BAT1, 0x80)
                        }
                    }
                    Method (_Q24, 0, NotSerialized)
                    {
                        CLPM ()
                        Notify (BAT0, 0x80)
                    }
                    Method (_Q25, 0, NotSerialized)
                    {
                        If (And (^BAT1.B1ST, ^BAT1.XB1S))
                        {
                            CLPM ()
                            Notify (BAT1, 0x80)
                        }
                    }
                    Method (BATW, 1, NotSerialized)
                    {
                        Store (\_SB.PCI0.LPC.EC.BAT1.XB1S, Local0)
                        If (LAnd (HB1A, LNot (SLUL)))
                        {
                            Store (0x01, Local1)
                        }
                        Else
                        {
                            Store (0x00, Local1)
                        }
                        If (XOr (Local0, Local1))
                        {
                            Store (Local1, \_SB.PCI0.LPC.EC.BAT1.XB1S)
                            Notify (\_SB.PCI0.LPC.EC.BAT1, 0x01)
                        }
                    }
                    Field (ECOR, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0xA0), 
                        SBRC,   16, 
                        SBFC,   16, 
                        SBAE,   16, 
                        SBRS,   16, 
                        SBAC,   16, 
                        SBVO,   16, 
                        SBAF,   16, 
                        SBBS,   16
                    }
                    Field (ECOR, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0xA0), 
                            ,   15, 
                        SBCM,   1, 
                        SBMD,   16, 
                        SBCC,   16
                    }
                    Field (ECOR, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0xA0), 
                        SBDC,   16, 
                        SBDV,   16, 
                        SBOM,   16, 
                        SBSI,   16, 
                        SBDT,   16, 
                        SBSN,   16
                    }
                    Field (ECOR, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0xA0), 
                        SBCH,   32
                    }
                    Field (ECOR, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0xA0), 
                        SBMN,   128
                    }
                    Field (ECOR, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0xA0), 
                        SBDN,   128
                    }
                    Mutex (BATM, 0x07)
                    Method (GBIF, 3, NotSerialized)
                    {
                        Acquire (BATM, 0xFFFF)
                        If (Arg2)
                        {
                            Or (Arg0, 0x01, HIID)
                            Store (SBCM, Local7)
                            XOr (Local7, 0x01, Index (Arg1, 0x00))
                            Store (Arg0, HIID)
                            If (Local7)
                            {
                                Multiply (SBFC, 0x0A, Local1)
                            }
                            Else
                            {
                                Store (SBFC, Local1)
                            }
                            Store (Local1, Index (Arg1, 0x02))
                            Or (Arg0, 0x02, HIID)
                            If (Local7)
                            {
                                Multiply (SBDC, 0x0A, Local0)
                            }
                            Else
                            {
                                Store (SBDC, Local0)
                            }
                            Store (Local0, Index (Arg1, 0x01))
                            Divide (Local1, 0x14, Local2, Index (Arg1, 0x05))
                            If (Local7)
                            {
                                Store (0xC8, Index (Arg1, 0x06))
                            }
                            Else
                            {
                                If (SBDV)
                                {
                                    Divide (0x00030D40, SBDV, Local2, Index (Arg1, 0x06))
                                }
                                Else
                                {
                                    Store (0x00, Index (Arg1, 0x06))
                                }
                            }
                            Store (SBDV, Index (Arg1, 0x04))
                            Store (SBSN, Local0)
                            Name (SERN, Buffer (0x06)
                            {
                                "     "
                            })
                            Store (0x04, Local2)
                            While (Local0)
                            {
                                Divide (Local0, 0x0A, Local1, Local0)
                                Add (Local1, 0x30, Index (SERN, Local2))
                                Decrement (Local2)
                            }
                            Store (SERN, Index (Arg1, 0x0A))
                            Or (Arg0, 0x06, HIID)
                            Store (SBDN, Index (Arg1, 0x09))
                            Or (Arg0, 0x04, HIID)
                            Name (BTYP, Buffer (0x05)
                            {
                                 0x00, 0x00, 0x00, 0x00, 0x00
                            })
                            Store (SBCH, BTYP)
                            Store (BTYP, Index (Arg1, 0x0B))
                            Or (Arg0, 0x05, HIID)
                            Store (SBMN, Index (Arg1, 0x0C))
                        }
                        Else
                        {
                            Store (0xFFFFFFFF, Index (Arg1, 0x01))
                            Store (0x00, Index (Arg1, 0x05))
                            Store (0x00, Index (Arg1, 0x06))
                            Store (0xFFFFFFFF, Index (Arg1, 0x02))
                        }
                        Release (BATM)
                        Return (Arg1)
                    }
                    Method (GBST, 4, NotSerialized)
                    {
                        Acquire (BATM, 0xFFFF)
                        If (And (Arg1, 0x20))
                        {
                            Store (0x02, Local0)
                        }
                        Else
                        {
                            If (And (Arg1, 0x40))
                            {
                                Store (0x01, Local0)
                            }
                            Else
                            {
                                Store (0x00, Local0)
                            }
                        }
                        If (And (Arg1, 0x0F)) {}
                        Else
                        {
                            Or (Local0, 0x04, Local0)
                        }
                        If (LEqual (And (Arg1, 0x0F), 0x0F))
                        {
                            Store (0x04, Local0)
                            Store (0x00, Local1)
                            Store (0x00, Local2)
                            Store (0x00, Local3)
                        }
                        Else
                        {
                            Store (Arg0, HIID)
                            Store (SBVO, Local3)
                            If (Arg2)
                            {
                                Multiply (SBRC, 0x0A, Local2)
                            }
                            Else
                            {
                                Store (SBRC, Local2)
                            }
                            Store (SBAC, Local1)
                            If (LGreaterEqual (Local1, 0x8000))
                            {
                                If (And (Local0, 0x01))
                                {
                                    Subtract (0x00010000, Local1, Local1)
                                }
                                Else
                                {
                                    Store (0x00, Local1)
                                }
                            }
                            Else
                            {
                                If (LNot (And (Local0, 0x02)))
                                {
                                    Store (0x00, Local1)
                                }
                            }
                            If (Arg2)
                            {
                                Multiply (Local3, Local1, Local1)
                                Divide (Local1, 0x03E8, Local7, Local1)
                            }
                        }
                        Store (Local0, Index (Arg3, 0x00))
                        Store (Local1, Index (Arg3, 0x01))
                        Store (Local2, Index (Arg3, 0x02))
                        Store (Local3, Index (Arg3, 0x03))
                        Release (BATM)
                        Return (Arg3)
                    }
                    Device (BAT0)
                    {
                        Name (_HID, EisaId ("PNP0C0A"))
                        Name (_UID, 0x00)
                        Name (_PCL, Package (0x01)
                        {
                            \_SB
                        })
                        Name (B0ST, 0x00)
                        Name (BT0I, Package (0x0D)
                        {
                            0x00, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0x01, 
                            0x2A30, 
                            0x00, 
                            0x00, 
                            0x01, 
                            0x01, 
                            "", 
                            "", 
                            "", 
                            ""
                        })
                        Name (BT0P, Package (0x04) {})
                        Method (_STA, 0, NotSerialized)
                        {
                            If (\H8DR)
                            {
                                Store (HB0A, B0ST)
                            }
                            Else
                            {
                                If (And (\RBEC (0x38), 0x80))
                                {
                                    Store (0x01, B0ST)
                                }
                                Else
                                {
                                    Store (0x00, B0ST)
                                }
                            }
                            If (B0ST)
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x0F)
                            }
                        }
                        Method (_BIF, 0, NotSerialized)
                        {
                            Store (0x00, Local7)
                            Store (0x0A, Local6)
                            While (LAnd (LNot (Local7), Local6))
                            {
                                If (HB0A)
                                {
                                    If (LEqual (And (HB0S, 0x0F), 0x0F))
                                    {
                                        Sleep (0x03E8)
                                        Decrement (Local6)
                                    }
                                    Else
                                    {
                                        Store (0x01, Local7)
                                    }
                                }
                                Else
                                {
                                    Store (0x00, Local6)
                                }
                            }
                            Return (GBIF (0x00, BT0I, Local7))
                        }
                        Method (_BST, 0, NotSerialized)
                        {
                            XOr (DerefOf (Index (BT0I, 0x00)), 0x01, Local0)
                            Return (GBST (0x00, HB0S, Local0, BT0P))
                        }
                        Method (_BTP, 1, NotSerialized)
                        {
                            And (HAM4, 0xEF, HAM4)
                            If (Arg0)
                            {
                                Store (Arg0, Local1)
                                If (LNot (DerefOf (Index (BT0I, 0x00))))
                                {
                                    Divide (Local1, 0x0A, Local0, Local1)
                                }
                                And (Local1, 0xFF, HT0L)
                                And (ShiftRight (Local1, 0x08), 0xFF, HT0H)
                                Or (HAM4, 0x10, HAM4)
                            }
                        }
                    }
                    Device (BAT1)
                    {
                        Name (_HID, EisaId ("PNP0C0A"))
                        Name (_UID, 0x01)
                        Name (_PCL, Package (0x01)
                        {
                            \_SB
                        })
                        Name (B1ST, 0x00)
                        Name (SBLI, 0x01)
                        Name (XB1S, 0x00)
                        Name (BT1I, Package (0x0D)
                        {
                            0x00, 
                            0xFFFFFFFF, 
                            0xFFFFFFFF, 
                            0x01, 
                            0x2A30, 
                            0x00, 
                            0x00, 
                            0x01, 
                            0x01, 
                            "", 
                            "", 
                            "", 
                            ""
                        })
                        Name (BT1P, Package (0x04) {})
                        Method (_STA, 0, NotSerialized)
                        {
                            If (\H8DR)
                            {
                                If (HB1A)
                                {
                                    Store (0x01, B1ST)
                                    If (SLUL)
                                    {
                                        Store (0x01, SBLI)
                                        Store (0x00, XB1S)
                                    }
                                    Else
                                    {
                                        Store (0x00, SBLI)
                                        Store (0x01, XB1S)
                                    }
                                }
                                Else
                                {
                                    Store (0x00, B1ST)
                                    Store (0x01, SBLI)
                                    Store (0x00, XB1S)
                                }
                            }
                            Else
                            {
                                If (And (\RBEC (0x39), 0x80))
                                {
                                    Store (0x01, B1ST)
                                    If (And (\RBEC (0x49), 0x01))
                                    {
                                        Store (0x01, SBLI)
                                        Store (0x00, XB1S)
                                    }
                                    Else
                                    {
                                        Store (0x00, SBLI)
                                        Store (0x01, XB1S)
                                    }
                                }
                                Else
                                {
                                    Store (0x00, B1ST)
                                    Store (0x01, SBLI)
                                    Store (0x00, XB1S)
                                }
                            }
                            If (B1ST)
                            {
                                If (XB1S)
                                {
                                    Return (0x1F)
                                }
                                Else
                                {
                                    If (\WNTF)
                                    {
                                        Return (0x00)
                                    }
                                    Else
                                    {
                                        Return (0x1F)
                                    }
                                }
                            }
                            Else
                            {
                                If (\WNTF)
                                {
                                    Return (0x00)
                                }
                                Else
                                {
                                    Return (0x0F)
                                }
                            }
                        }
                        Method (_BIF, 0, NotSerialized)
                        {
                            Store (0x00, Local7)
                            Store (0x0A, Local6)
                            While (LAnd (LNot (Local7), Local6))
                            {
                                If (HB1A)
                                {
                                    If (LEqual (And (HB1S, 0x0F), 0x0F))
                                    {
                                        Sleep (0x03E8)
                                        Decrement (Local6)
                                    }
                                    Else
                                    {
                                        Store (0x01, Local7)
                                    }
                                }
                                Else
                                {
                                    Store (0x00, Local6)
                                }
                            }
                            Return (GBIF (0x10, BT1I, Local7))
                        }
                        Method (_BST, 0, NotSerialized)
                        {
                            XOr (DerefOf (Index (BT1I, 0x00)), 0x01, Local0)
                            Return (GBST (0x10, HB1S, Local0, BT1P))
                        }
                        Method (_BTP, 1, NotSerialized)
                        {
                            And (HAM4, 0xDF, HAM4)
                            If (Arg0)
                            {
                                Store (Arg0, Local1)
                                If (LNot (DerefOf (Index (BT1I, 0x00))))
                                {
                                    Divide (Local1, 0x0A, Local0, Local1)
                                }
                                And (Local1, 0xFF, HT1L)
                                And (ShiftRight (Local1, 0x08), 0xFF, HT1H)
                                Or (HAM4, 0x20, HAM4)
                            }
                        }
                        Method (_EJ0, 1, NotSerialized)
                        {
                            If (Arg0)
                            {
                                Store (0x00, B1ST)
                                Store (0x01, SBLI)
                                Store (0x00, XB1S)
                            }
                        }
                    }
                    Device (AC)
                    {
                        Name (_HID, "ACPI0003")
                        Name (_UID, 0x00)
                        Name (_PCL, Package (0x01)
                        {
                            \_SB
                        })
                        Method (_PSR, 0, NotSerialized)
                        {
                            If (\H8DR)
                            {
                                If (HPAC)
                                {
                                    If (DOCD)
                                    {
                                        If (\_SB.PCI0.LPC.EPWG)
                                        {
                                            Return (0x01)
                                        }
                                        Else
                                        {
                                            Return (0x00)
                                        }
                                    }
                                    Else
                                    {
                                        Return (0x01)
                                    }
                                }
                                Else
                                {
                                    Return (0x00)
                                }
                            }
                            Else
                            {
                                If (And (\RBEC (0x46), 0x10))
                                {
                                    Return (0x01)
                                }
                                Else
                                {
                                    Return (0x00)
                                }
                            }
                        }
                        Method (_STA, 0, NotSerialized)
                        {
                            Return (0x0F)
                        }
                    }
                    Device (HKEY)
                    {
                        Name (_HID, EisaId ("LEN0068"))
                        Method (_STA, 0, NotSerialized)
                        {
                            Return (0x0F)
                        }
                        Method (MHKV, 0, NotSerialized)
                        {
                            Return (0x0100)
                        }
                        Name (DHKC, 0x00)
                        Name (DHKB, 0x01)
                        Mutex (XDHK, 0x07)
                        Name (DHKH, 0x00)
                        Name (DHKW, 0x00)
                        Name (DHKS, 0x00)
                        Name (DHKD, 0x00)
                        Name (DHKN, 0x080C)
                        Name (DHKT, 0x00)
                        Name (DHWW, 0x00)
                        Method (MHKA, 0, NotSerialized)
                        {
                            Return (0x07FFFFFF)
                        }
                        Method (MHKN, 0, NotSerialized)
                        {
                            Return (DHKN)
                        }
                        Method (MHKK, 1, NotSerialized)
                        {
                            If (DHKC)
                            {
                                Return (And (DHKN, Arg0))
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }
                        Method (MHKM, 2, NotSerialized)
                        {
                            Acquire (XDHK, 0xFFFF)
                            If (LGreater (Arg0, 0x20))
                            {
                                Noop
                            }
                            Else
                            {
                                ShiftLeft (One, Decrement (Arg0), Local0)
                                If (And (Local0, 0x07FFFFFF))
                                {
                                    If (Arg1)
                                    {
                                        Or (Local0, DHKN, DHKN)
                                    }
                                    Else
                                    {
                                        And (DHKN, XOr (Local0, 0xFFFFFFFF), DHKN)
                                    }
                                }
                                Else
                                {
                                    Noop
                                }
                            }
                            Release (XDHK)
                        }
                        Method (MHKS, 0, NotSerialized)
                        {
                            Notify (\_SB.SLPB, 0x80)
                        }
                        Method (MHKC, 1, NotSerialized)
                        {
                            Store (Arg0, DHKC)
                        }
                        Method (MHKP, 0, NotSerialized)
                        {
                            Acquire (XDHK, 0xFFFF)
                            If (DHWW)
                            {
                                Store (DHWW, Local1)
                                Store (Zero, DHWW)
                            }
                            Else
                            {
                                If (DHKW)
                                {
                                    Store (DHKW, Local1)
                                    Store (Zero, DHKW)
                                }
                                Else
                                {
                                    If (DHKD)
                                    {
                                        Store (DHKD, Local1)
                                        Store (Zero, DHKD)
                                    }
                                    Else
                                    {
                                        If (DHKS)
                                        {
                                            Store (DHKS, Local1)
                                            Store (Zero, DHKS)
                                        }
                                        Else
                                        {
                                            If (DHKT)
                                            {
                                                Store (DHKT, Local1)
                                                Store (Zero, DHKT)
                                            }
                                            Else
                                            {
                                                Store (DHKH, Local1)
                                                Store (Zero, DHKH)
                                            }
                                        }
                                    }
                                }
                            }
                            Release (XDHK)
                            Return (Local1)
                        }
                        Method (MHKE, 1, NotSerialized)
                        {
                            Store (Arg0, DHKB)
                            Acquire (XDHK, 0xFFFF)
                            Store (Zero, DHKH)
                            Store (Zero, DHKW)
                            Store (Zero, DHKS)
                            Store (Zero, DHKD)
                            Store (Zero, DHKT)
                            Store (Zero, DHWW)
                            Release (XDHK)
                        }
                        Method (MHKQ, 1, NotSerialized)
                        {
                            If (DHKB)
                            {
                                If (DHKC)
                                {
                                    Acquire (XDHK, 0xFFFF)
                                    If (LLess (Arg0, 0x1000)) {}
                                    Else
                                    {
                                        If (LLess (Arg0, 0x2000))
                                        {
                                            Store (Arg0, DHKH)
                                        }
                                        Else
                                        {
                                            If (LLess (Arg0, 0x3000))
                                            {
                                                Store (Arg0, DHKW)
                                            }
                                            Else
                                            {
                                                If (LLess (Arg0, 0x4000))
                                                {
                                                    Store (Arg0, DHKS)
                                                }
                                                Else
                                                {
                                                    If (LLess (Arg0, 0x5000))
                                                    {
                                                        Store (Arg0, DHKD)
                                                    }
                                                    Else
                                                    {
                                                        If (LLess (Arg0, 0x6000))
                                                        {
                                                            Store (Arg0, DHKH)
                                                        }
                                                        Else
                                                        {
                                                            If (LLess (Arg0, 0x7000))
                                                            {
                                                                Store (Arg0, DHKT)
                                                            }
                                                            Else
                                                            {
                                                                If (LLess (Arg0, 0x8000))
                                                                {
                                                                    Store (Arg0, DHWW)
                                                                }
                                                                Else
                                                                {
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    Release (XDHK)
                                    Notify (HKEY, 0x80)
                                }
                                Else
                                {
                                    If (LEqual (Arg0, 0x1004))
                                    {
                                        Notify (\_SB.SLPB, 0x80)
                                    }
                                }
                            }
                        }
                        Method (MHKB, 1, NotSerialized)
                        {
                            If (LEqual (Arg0, 0x00))
                            {
                                \_SB.PCI0.LPC.EC.BEEP (0x11)
                                Store (0x00, \LIDB)
                            }
                            Else
                            {
                                If (LEqual (Arg0, 0x01))
                                {
                                    \_SB.PCI0.LPC.EC.BEEP (0x10)
                                    Store (0x01, \LIDB)
                                }
                                Else
                                {
                                }
                            }
                        }
                        Method (MHKD, 0, NotSerialized)
                        {
                            If (LEqual (\PLUX, 0x00))
                            {
                                If (VIGD)
                                {
                                    \_SB.PCI0.VID.VLOC (0x00)
                                }
                                Else
                                {
                                    \_SB.PCI0.PEG.VID.VLOC (0x00)
                                }
                            }
                        }
                        Method (MHQC, 1, NotSerialized)
                        {
                            If (\WNTF)
                            {
                                If (LEqual (Arg0, 0x00))
                                {
                                    Return (\CWAC)
                                }
                                Else
                                {
                                    If (LEqual (Arg0, 0x01))
                                    {
                                        Return (\CWAP)
                                    }
                                    Else
                                    {
                                        If (LEqual (Arg0, 0x02))
                                        {
                                            Return (\CWAT)
                                        }
                                        Else
                                        {
                                            Noop
                                        }
                                    }
                                }
                            }
                            Else
                            {
                                Noop
                            }
                            Return (0x00)
                        }
                        Method (MHGC, 0, NotSerialized)
                        {
                            If (\WNTF)
                            {
                                Acquire (XDHK, 0xFFFF)
                                If (CKC4 (0x00))
                                {
                                    Store (0x03, Local0)
                                }
                                Else
                                {
                                    Store (0x04, Local0)
                                }
                                Release (XDHK)
                                Return (Local0)
                            }
                            Else
                            {
                                Noop
                            }
                            Return (0x00)
                        }
                        Method (MHSC, 1, NotSerialized)
                        {
                            If (LAnd (\CWAC, \WNTF))
                            {
                                Acquire (XDHK, 0xFFFF)
                                If (\OSC4)
                                {
                                    If (LEqual (Arg0, 0x03))
                                    {
                                        If (LNot (\CWAS))
                                        {
                                            \PNTF (0x81)
                                            Store (0x01, \CWAS)
                                        }
                                    }
                                    Else
                                    {
                                        If (LEqual (Arg0, 0x04))
                                        {
                                            If (\CWAS)
                                            {
                                                \PNTF (0x81)
                                                Store (0x00, \CWAS)
                                            }
                                        }
                                        Else
                                        {
                                            Noop
                                        }
                                    }
                                }
                                Release (XDHK)
                            }
                            Else
                            {
                                Noop
                            }
                        }
                        Method (CKC4, 1, NotSerialized)
                        {
                            Store (0x00, Local0)
                            If (\C4WR)
                            {
                                If (LNot (\C4AC))
                                {
                                    Or (Local0, 0x01, Local0)
                                }
                            }
                            If (\C4NA)
                            {
                                Or (Local0, 0x02, Local0)
                            }
                            If (LAnd (\CWAC, \CWAS))
                            {
                                Or (Local0, 0x04, Local0)
                            }
                            If (LAnd (\CWUE, \CWUS))
                            {
                                Or (Local0, 0x08, Local0)
                            }
                            And (Local0, Not (Arg0), Local0)
                            Return (Local0)
                        }
                        Method (MHQE, 0, NotSerialized)
                        {
                            Return (\C4WR)
                        }
                        Method (MHGE, 0, NotSerialized)
                        {
                            If (LAnd (\C4WR, \C4AC))
                            {
                                Return (0x04)
                            }
                            Return (0x03)
                        }
                        Method (MHSE, 1, NotSerialized)
                        {
                            If (\C4WR)
                            {
                                Store (\C4AC, Local0)
                                If (LEqual (Arg0, 0x03))
                                {
                                    Store (0x00, \C4AC)
                                    If (XOr (Local0, \C4AC))
                                    {
                                        If (\OSC4)
                                        {
                                            \PNTF (0x81)
                                        }
                                    }
                                }
                                Else
                                {
                                    If (LEqual (Arg0, 0x04))
                                    {
                                        Store (0x01, \C4AC)
                                        If (XOr (Local0, \C4AC))
                                        {
                                            If (\OSC4)
                                            {
                                                \PNTF (0x81)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        Method (UAWO, 1, NotSerialized)
                        {
                            Return (\UAWS (Arg0))
                        }
                        Method (KLCG, 1, NotSerialized)
                        {
                            Store (\PKLI, Local0)
                            ShiftLeft (Local0, 0x08, Local0)
                            Store (\_SB.PCI0.LPC.EC.KBLT, Local1)
                            Or (Local0, Local1, Local0)
                            Return (Local0)
                        }
                        Method (KLCS, 1, NotSerialized)
                        {
                            If (\_SB.PCI0.LPC.EC.HKEY.MHKK (0x00020000))
                            {
                                \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x1012)
                            }
                            And (Arg0, 0xFF, Local0)
                            If (LEqual (Local0, Zero))
                            {
                                \UCMS (0x0D)
                            }
                            Else
                            {
                                \UCMS (0x0C)
                            }
                            Return (0x00)
                        }
                        Method (DSSG, 1, NotSerialized)
                        {
                            Or (0x0400, \PDCI, Local0)
                            Return (Local0)
                        }
                        Method (DSSS, 1, NotSerialized)
                        {
                            Or (\PDCI, Arg0, \PDCI)
                        }
                        Method (SBSG, 1, NotSerialized)
                        {
                            Return (\SYBC (0x00, 0x00))
                        }
                        Method (SBSS, 1, NotSerialized)
                        {
                            Return (\SYBC (0x01, Arg0))
                        }
                        Method (PBLG, 1, NotSerialized)
                        {
                            Store (\BRLV, Local0)
                            Or (Local0, 0x0F00, Local1)
                            Return (Local1)
                        }
                        Method (PBLS, 1, NotSerialized)
                        {
                            Store (Arg0, \BRLV)
                            If (\VIGD)
                            {
                                \_SB.PCI0.LPC.EC.BRNS ()
                            }
                            Else
                            {
                                \VBRC (\BRLV)
                            }
                            If (LNot (\NBCF))
                            {
                                \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x6050)
                            }
                            Return (0x00)
                        }
                        Method (PMSG, 1, NotSerialized)
                        {
                            Return (\PRSM (0x00, 0x00))
                        }
                        Method (PMSS, 1, NotSerialized)
                        {
                            \PRSM (0x01, Arg0)
                            Return (0x00)
                        }
                    }
                    Scope (\_SB.PCI0.LPC.EC.HKEY)
                    {
                        Name (INDV, 0x00)
                        Method (MHQI, 0, NotSerialized)
                        {
                            If (And (\IPMS, 0x01))
                            {
                                Or (INDV, 0x01, INDV)
                            }
                            If (And (\IPMS, 0x02))
                            {
                                Or (INDV, 0x02, INDV)
                            }
                            If (And (\IPMS, 0x04))
                            {
                                Or (INDV, 0x0100, INDV)
                            }
                            If (And (\IPMS, 0x08))
                            {
                                Or (INDV, 0x0200, INDV)
                            }
                            If (And (\IPMS, 0x10))
                            {
                                Or (INDV, 0x04, INDV)
                            }
                            Return (INDV)
                        }
                        Method (MHGI, 1, NotSerialized)
                        {
                            Name (RETB, Buffer (0x10) {})
                            CreateByteField (RETB, 0x00, MHGS)
                            ShiftLeft (0x01, Arg0, Local0)
                            If (And (INDV, Local0))
                            {
                                If (LEqual (Arg0, 0x00))
                                {
                                    CreateField (RETB, 0x08, 0x78, BRBU)
                                    Store (\IPMB, BRBU)
                                    Store (0x10, MHGS)
                                }
                                Else
                                {
                                    If (LEqual (Arg0, 0x01))
                                    {
                                        CreateField (RETB, 0x08, 0x18, RRBU)
                                        Store (\IPMR, RRBU)
                                        Store (0x04, MHGS)
                                    }
                                    Else
                                    {
                                        If (LEqual (Arg0, 0x08))
                                        {
                                            CreateField (RETB, 0x10, 0x18, ODBU)
                                            CreateByteField (RETB, 0x01, MHGZ)
                                            Store (\IPMO, ODBU)
                                            If (LEqual (^^BDEV, 0x03))
                                            {
                                                If (\H8DR)
                                                {
                                                    Store (^^HPBU, Local1)
                                                }
                                                Else
                                                {
                                                    And (\RBEC (0x47), 0x01, Local1)
                                                }
                                                If (LNot (Local1))
                                                {
                                                    Or (0x04, MHGZ, MHGZ)
                                                }
                                                If (LEqual (^^BSTS, 0x00))
                                                {
                                                    Or (0x01, MHGZ, MHGZ)
                                                    Or (0x02, MHGZ, MHGZ)
                                                }
                                            }
                                            Store (0x05, MHGS)
                                        }
                                        Else
                                        {
                                            If (LEqual (Arg0, 0x09))
                                            {
                                                CreateField (RETB, 0x10, 0x08, AUBU)
                                                Store (\IPMA, AUBU)
                                                Store (0x01, Index (RETB, 0x01))
                                                Store (0x03, MHGS)
                                            }
                                            Else
                                            {
                                                If (LEqual (Arg0, 0x02))
                                                {
                                                    Store (\VDYN (0x00, 0x00), Local1)
                                                    And (Local1, 0x0F, Index (RETB, 0x02))
                                                    ShiftRight (Local1, 0x04, Local1)
                                                    And (Local1, 0x0F, Index (RETB, 0x01))
                                                    Store (0x03, MHGS)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            Return (RETB)
                        }
                        Method (MHSI, 2, NotSerialized)
                        {
                            ShiftLeft (0x01, Arg0, Local0)
                            If (And (INDV, Local0))
                            {
                                If (LEqual (Arg0, 0x08))
                                {
                                    If (Arg1)
                                    {
                                        If (\H8DR)
                                        {
                                            Store (^^HPBU, Local1)
                                        }
                                        Else
                                        {
                                            And (\RBEC (0x47), 0x01, Local1)
                                        }
                                        If (LNot (Local1))
                                        {
                                            Store (^^BGID (0x00), ^^BDEV)
                                            ^^NBIN (Local1)
                                        }
                                    }
                                }
                                Else
                                {
                                    If (LEqual (Arg0, 0x02))
                                    {
                                        \VDYN (0x01, Arg1)
                                    }
                                }
                            }
                        }
                    }
                    Scope (\_SB.PCI0.LPC.EC)
                    {
                        Method (_Q6A, 0, NotSerialized)
                        {
                            If (HDMC)
                            {
                                Noop
                            }
                            Else
                            {
                                If (\_SB.PCI0.LPC.EC.HKEY.MHKK (0x04000000))
                                {
                                    \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x101B)
                                }
                            }
                        }
                    }
                    Scope (\_SB.PCI0.LPC.EC.HKEY)
                    {
                        Method (MMTG, 0, NotSerialized)
                        {
                            Store (0x0101, Local0)
                            If (HDMC)
                            {
                                Or (Local0, 0x00010000, Local0)
                            }
                            Return (Local0)
                        }
                        Method (MMTS, 1, NotSerialized)
                        {
                            If (HDMC)
                            {
                                Noop
                            }
                            Else
                            {
                                If (LEqual (Arg0, 0x02))
                                {
                                    \_SB.PCI0.LPC.EC.LED (0x0E, 0x80)
                                }
                                Else
                                {
                                    If (LEqual (Arg0, 0x03))
                                    {
                                        \_SB.PCI0.LPC.EC.LED (0x0E, 0xC0)
                                    }
                                    Else
                                    {
                                        \_SB.PCI0.LPC.EC.LED (0x0E, 0x00)
                                    }
                                }
                            }
                        }
                    }
                    Scope (\_SB.PCI0.LPC.EC.HKEY)
                    {
                        Method (PWMC, 0, NotSerialized)
                        {
                            Return (0x01)
                        }
                        Method (PWMG, 0, NotSerialized)
                        {
                            Store (\_SB.PCI0.LPC.EC.PWMH, Local0)
                            ShiftLeft (Local0, 0x08, Local0)
                            Or (Local0, \_SB.PCI0.LPC.EC.PWML, Local0)
                            Return (Local0)
                        }
                    }
                    Scope (\_SB.PCI0.LPC.EC)
                    {
                        Method (_Q45, 0, NotSerialized)
                        {
                            If (DOCD)
                            {
                                Sleep (0x64)
                                If (\_SB.PCI0.LPC.EPWG)
                                {
                                    Noop
                                }
                                Else
                                {
                                    If (HPAC)
                                    {
                                        _Q27 ()
                                    }
                                }
                                \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x4010)
                            }
                            Else
                            {
                                Sleep (0x64)
                                If (HPAC)
                                {
                                    _Q26 ()
                                }
                                \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x4011)
                            }
                        }
                        Method (DKID, 0, NotSerialized)
                        {
                            Store (\_SB.PCI0.LPC.DOI0, Local0)
                            Store (\_SB.PCI0.LPC.DOI1, Local1)
                            Store (\_SB.PCI0.LPC.DOI2, Local2)
                            Or (Local0, ShiftLeft (Local1, 0x01), Local0)
                            Or (Local0, ShiftLeft (Local2, 0x02), Local0)
                            Return (Local0)
                        }
                    }
                    Scope (\_SB.PCI0.LPC.EC.HKEY)
                    {
                        Method (GDKS, 0, NotSerialized)
                        {
                            Store (0x00, Local0)
                            If (LEqual (\_SB.PCI0.LPC.EC.DOCD, 0x01))
                            {
                                Or (Local0, 0x01, Local0)
                                Store (\_SB.PCI0.LPC.EC.DKID (), Local1)
                                ShiftLeft (Local1, 0x08, Local1)
                                Or (Local0, Local1, Local0)
                            }
                            If (LEqual (\_SB.PCI0.LPC.EC.HB1A, 0x01))
                            {
                                If (LEqual (\_SB.PCI0.LPC.EC.SLUL, 0x01))
                                {
                                    Or (Local0, 0x04, Local0)
                                }
                            }
                            Return (Local0)
                        }
                    }
                    Scope (\_SB.PCI0.LPC.EC)
                    {
                        Method (_Q3F, 0, NotSerialized)
                        {
                            \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x6000)
                        }
                    }
                    Scope (\_SB.PCI0.LPC.EC.HKEY)
                    {
                        Method (NUMG, 0, NotSerialized)
                        {
                            Store (0x01, Local0)
                            If (\_SB.PCI0.LPC.EC.SNLK)
                            {
                                And (Local0, Not (0x02), Local0)
                            }
                            Else
                            {
                                Or (Local0, 0x02, Local0)
                            }
                            If (\_SB.PCI0.LPC.EC.NULS)
                            {
                                Or (Local0, 0x0100, Local0)
                            }
                            Else
                            {
                                And (Local0, Not (0x0100), Local0)
                            }
                            Return (Local0)
                        }
                    }
                }
            }
            Device (PEG)
            {
                Name (_ADR, 0x00010000)
                Name (_S3D, 0x03)
                Name (RID, 0x00)
                Name (LART, Package (0x02)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        \_SB.LNKA, 
                        0x00
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        \_SB.LNKB, 
                        0x00
                    }
                })
                Name (AART, Package (0x02)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        0x00, 
                        0x10
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        0x00, 
                        0x11
                    }
                })
                Method (_PRT, 0, NotSerialized)
                {
                    If (\GPIC)
                    {
                        Return (AART)
                    }
                    Else
                    {
                        Return (LART)
                    }
                }
                Mutex (MDGS, 0x07)
                Name (VDEE, 0x01)
                Name (VDDA, Buffer (0x04) {})
                CreateBitField (VDDA, 0x00, VUPC)
                CreateBitField (VDDA, 0x01, VQDL)
                CreateBitField (VDDA, 0x02, VQDC)
                CreateBitField (VDDA, 0x03, VQD0)
                CreateBitField (VDDA, 0x04, VQD1)
                CreateBitField (VDDA, 0x05, VQD2)
                CreateBitField (VDDA, 0x06, VQD3)
                CreateBitField (VDDA, 0x07, VQD4)
                CreateBitField (VDDA, 0x08, VQD5)
                CreateBitField (VDDA, 0x09, VSDL)
                CreateBitField (VDDA, 0x0A, VSDC)
                CreateBitField (VDDA, 0x0B, VSD0)
                CreateBitField (VDDA, 0x0C, VSD1)
                CreateBitField (VDDA, 0x0D, VSD2)
                CreateBitField (VDDA, 0x0E, VSD3)
                CreateBitField (VDDA, 0x0F, VSD4)
                CreateBitField (VDDA, 0x10, VSD5)
                CreateBitField (VDDA, 0x11, MSWT)
                CreateBitField (VDDA, 0x12, VWST)
                Device (VID)
                {
                    Name (_ADR, 0x00)
                    OperationRegion (VPCG, PCI_Config, 0x00, 0x0100)
                    Field (VPCG, DWordAcc, NoLock, Preserve)
                    {
                        Offset (0x2C), 
                        VSID,   32, 
                        Offset (0x70), 
                        VPWR,   8
                    }
                    Name (_S3D, 0x03)
                    Name (DGOS, 0x00)
                    Method (_INI, 0, NotSerialized)
                    {
                        \VUPS (0x02)
                        Store (\VCDL, VQDL)
                        Store (\VCDC, VQDC)
                        Store (\VCDT, VQD0)
                        Store (\VCDD, VQD1)
                        If (ISOP ())
                        {
                            \VHYB (0x04, 0x01)
                        }
                    }
                    Method (_PS0, 0, NotSerialized)
                    {
                        If (ISOP ())
                        {
                            If (DGOS)
                            {
                                Store (0x01, \TDNV)
                                If (And (\PPMF, 0x01))
                                {
                                    If (\OSPX)
                                    {
                                        \PNTF (0x80)
                                    }
                                }
                                \VHYB (0x02, 0x00)
                                Sleep (0x64)
                                \VHYB (0x00, 0x01)
                                Sleep (0x0A)
                                Store (0x01, \_SB.PCI0.LPC.PCRS)
                                Store (0x01, \_SB.PCI0.LPC.PCRQ)
                                Sleep (0x64)
                                \VHYB (0x02, 0x01)
                                Sleep (0x01)
                                \VHYB (0x08, 0x01)
                                Store (0x0A, Local0)
                                Store (0x32, Local1)
                                While (Local1)
                                {
                                    Sleep (Local0)
                                    If (\LCHK (0x01))
                                    {
                                        Break
                                    }
                                    Decrement (Local1)
                                }
                                Store (0x00, \_SB.PCI0.LPC.PCRQ)
                                \VHYB (0x04, 0x00)
                                \SWTT (0x01)
                                Store (Zero, DGOS)
                            }
                            Else
                            {
                                If (LNotEqual (VSID, 0x21D117AA))
                                {
                                    \VHYB (0x04, 0x00)
                                }
                            }
                            \VHYB (0x09, \_SB.PCI0.PEG.VID.HDAS)
                        }
                    }
                    Method (_PS1, 0, NotSerialized)
                    {
                        Noop
                    }
                    Method (_PS2, 0, NotSerialized)
                    {
                        Noop
                    }
                    Method (_PS3, 0, NotSerialized)
                    {
                        If (ISOP ())
                        {
                            If (LEqual (\_SB.PCI0.PEG.VID.OMPR, 0x03))
                            {
                                \SWTT (0x00)
                                \VHYB (0x08, 0x00)
                                Store (0x0A, Local0)
                                Store (0x32, Local1)
                                While (Local1)
                                {
                                    Sleep (Local0)
                                    If (\LCHK (0x00))
                                    {
                                        Break
                                    }
                                    Decrement (Local1)
                                }
                                \VHYB (0x02, 0x00)
                                Sleep (0x64)
                                \VHYB (0x00, 0x00)
                                Store (One, DGOS)
                                Store (0x02, \_SB.PCI0.PEG.VID.OMPR)
                                Store (0x00, \TDNV)
                                If (And (\PPMF, 0x01))
                                {
                                    If (\OSPX)
                                    {
                                        \PNTF (0x80)
                                    }
                                }
                            }
                        }
                    }
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }
                    Name (_SUN, One)
                    Method (_DSM, 4, NotSerialized)
                    {
                        Store (Package (0x22)
                            {
                                "AAPL,backlight-control", 
                                Buffer (0x04)
                                {
                                     0x01, 0x00, 0x00, 0x00
                                }, 
                                "@0,backlight-control", 
                                Buffer (0x04)
                                {
                                     0x01, 0x00, 0x00, 0x00
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
                                "@0,display_cfg", 
                                Buffer (0x08)
                                {
                                     0xFF, 0xFF, 0xFF, 0xFF
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
                                "@1,display_cfg", 
                                Buffer (0x08)
                                {
                                     0xFF, 0xFF, 0x00, 0x01
                                }, 
                                "@1,name", 
                                Buffer (0x0F)
                                {
                                    "NVDA,Display-B"
                                }, 
                                "@0,built-in", 
                                Buffer (One)
                                {
                                     0x01
                                }, 
                                "@0,pwm-info", 
                                Buffer (0x14)
                                {
                                    /* 0000 */   0x01, 0x14, 0x00, 0x64, 0xA8, 0x61, 0x00, 0x00,
                                    /* 0008 */   0x08, 0x52, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
                                    /* 0010 */   0x00, 0x04, 0x00, 0x00
                                }, 
                                "NVCAP", 
                                Buffer (0x14)
                                {
                                    /* 0000 */   0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00,
                                    /* 0008 */   0xFE, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0A,
                                    /* 0010 */   0x00, 0x00, 0x00, 0x00
                                }, 
                                "VRAM,totalsize", 
                                Buffer (0x04)
                                {
                                     0x00, 0x00, 0x00, 0x80
                                }, 
                                "device_type", 
                                Buffer (0x0D)
                                {
                                    "NVDA,Parent"
                                }, 
                                "model", 
                                Buffer (0x14)
                                {
                                    "NVidia Quadro 2000M"
                                }, 
                                "rom-revision", 
                                Buffer (0x22)
                                {
                                    "NVidia Quadro 2000M OpenGL Engine"
                                }
                            }, Local0)
                        DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                        Return (Local0)
                    }
                    Name (IRC, 0x00)
                    OperationRegion (ATRP, SystemMemory, \ATRB, 0x00010000)
                    Field (ATRP, AnyAcc, Lock, Preserve)
                    {
                        IDX0,   262144, 
                        IDX1,   262144
                    }
                    Method (_ROM, 2, Serialized)
                    {
                        If (LGreaterEqual (Arg0, 0x8000))
                        {
                            Return (GETB (Subtract (Arg0, 0x8000), Arg1, IDX1))
                        }
                        If (LGreater (Add (Arg0, Arg1), 0x8000))
                        {
                            Subtract (0x8000, Arg0, Local0)
                            Subtract (Arg1, Local0, Local1)
                            Store (GETB (Arg0, Local0, IDX0), Local3)
                            Store (GETB (0x00, Local1, IDX1), Local4)
                            Concatenate (Local3, Local4, Local5)
                            Return (Local5)
                        }
                        Return (GETB (Arg0, Arg1, IDX0))
                    }
                    Method (GETB, 3, Serialized)
                    {
                        Multiply (Arg0, 0x08, Local0)
                        Multiply (Arg1, 0x08, Local1)
                        CreateField (Arg2, Local0, Local1, TBF3)
                        Return (TBF3)
                    }
                    Method (VSWT, 0, NotSerialized)
                    {
                        If (\WVIS)
                        {
                            Store (\VEVT (0x07), Local0)
                        }
                        Else
                        {
                            Store (\VEVT (0x05), Local0)
                        }
                        And (0xFF, Local0, Local1)
                        If (Local1)
                        {
                            ASWT (Local1, 0x01)
                        }
                    }
                    Method (VLOC, 1, NotSerialized)
                    {
                        If (LEqual (Arg0, \_SB.LID._LID ()))
                        {
                            \VSLD (Arg0)
                            Store (0x00, Local0)
                            If (LEqual (And (VPWR, 0x03), 0x00))
                            {
                                If (Arg0)
                                {
                                    If (LOr (\WIN7, \WVIS)) {}
                                    Else
                                    {
                                        Store (\VEVT (0x01), Local0)
                                    }
                                }
                                Else
                                {
                                    If (LOr (\WIN7, \WVIS)) {}
                                    Else
                                    {
                                        Store (\VEVT (0x02), Local0)
                                    }
                                }
                                And (0x0F, Local0, Local1)
                                If (Local1)
                                {
                                    ASWT (Local1, 0x00)
                                }
                            }
                        }
                    }
                    Method (_DOS, 1, NotSerialized)
                    {
                        If (LEqual (Arg0, 0x02))
                        {
                            Store (0x14, Local0)
                            While (Local0)
                            {
                                Decrement (Local0)
                                Acquire (MDGS, 0xFFFF)
                                If (LEqual (0x00, MSWT))
                                {
                                    Store (0x01, MSWT)
                                    Store (0x00, Local0)
                                    Store (Arg0, VDEE)
                                }
                                Release (MDGS)
                                Sleep (0xC8)
                            }
                        }
                        Else
                        {
                            Acquire (MDGS, 0xFFFF)
                            If (LEqual (VDEE, 0x02))
                            {
                                Store (0x00, MSWT)
                            }
                            If (LGreater (Arg0, 0x02))
                            {
                                Store (0x01, VDEE)
                            }
                            Else
                            {
                                Store (Arg0, VDEE)
                            }
                            Release (MDGS)
                        }
                    }
                    Method (_DOD, 0, NotSerialized)
                    {
                        Return (Package (0x08)
                        {
                            0x0100, 
                            0x0114, 
                            0x0111, 
                            0x0115, 
                            0x0112, 
                            0x0116, 
                            0x0113, 
                            0x0110
                        })
                    }
                    Method (ASWT, 2, NotSerialized)
                    {
                        If (LEqual (0x01, VDEE))
                        {
                            And (0x01, Arg1, Local1)
                            \VSDS (Arg0, Local1)
                        }
                        Else
                        {
                            Store (0x14, Local0)
                            While (Local0)
                            {
                                Decrement (Local0)
                                Acquire (MDGS, 0xFFFF)
                                If (LEqual (0x00, MSWT))
                                {
                                    Store (0x00, Local0)
                                    If (And (0x01, Arg1))
                                    {
                                        Store (0x01, VUPC)
                                    }
                                    Else
                                    {
                                        Store (0x00, VUPC)
                                    }
                                    If (And (0x01, Arg0))
                                    {
                                        Store (0x01, VQDL)
                                    }
                                    Else
                                    {
                                        Store (0x00, VQDL)
                                    }
                                    If (And (0x02, Arg0))
                                    {
                                        Store (0x01, VQDC)
                                    }
                                    Else
                                    {
                                        Store (0x00, VQDC)
                                    }
                                    If (And (0x04, Arg0))
                                    {
                                        Store (0x01, VQD0)
                                    }
                                    Else
                                    {
                                        Store (0x00, VQD0)
                                    }
                                    If (And (0x08, Arg0))
                                    {
                                        Store (0x01, VQD1)
                                    }
                                    Else
                                    {
                                        Store (0x00, VQD1)
                                    }
                                    If (And (0x10, Arg0))
                                    {
                                        Store (0x01, VQD2)
                                    }
                                    Else
                                    {
                                        Store (0x00, VQD2)
                                    }
                                    If (And (0x20, Arg0))
                                    {
                                        Store (0x01, VQD3)
                                    }
                                    Else
                                    {
                                        Store (0x00, VQD3)
                                    }
                                    If (And (0x40, Arg0))
                                    {
                                        Store (0x01, VQD4)
                                    }
                                    Else
                                    {
                                        Store (0x00, VQD4)
                                    }
                                    If (And (0x80, Arg0))
                                    {
                                        Store (0x01, VQD5)
                                    }
                                    Else
                                    {
                                        Store (0x00, VQD5)
                                    }
                                }
                                Release (MDGS)
                                Sleep (0xC8)
                            }
                            If (And (0x02, Arg1))
                            {
                                Notify (VID, 0x81)
                            }
                            Else
                            {
                                Notify (VID, 0x80)
                            }
                        }
                    }
                    Method (VDSW, 1, NotSerialized)
                    {
                        If (LEqual (VPWR, 0x00))
                        {
                            If (Arg0)
                            {
                                Store (\VEVT (0x03), Local0)
                            }
                            Else
                            {
                                Store (\VEVT (0x04), Local0)
                            }
                            And (0x0F, Local0, Local1)
                            If (Local1)
                            {
                                ASWT (Local1, 0x00)
                            }
                        }
                    }
                    Device (LCD0)
                    {
                        Method (_ADR, 0, NotSerialized)
                        {
                            Return (0x0110)
                        }
                        Method (_DCS, 0, NotSerialized)
                        {
                            \VUPS (0x00)
                            If (\VCDL)
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x1D)
                            }
                        }
                        Method (_DGS, 0, NotSerialized)
                        {
                            Return (VQDL)
                        }
                        Method (_DSS, 1, NotSerialized)
                        {
                            And (Arg0, 0x01, VSDL)
                            If (And (Arg0, 0x80000000))
                            {
                                If (And (Arg0, 0x40000000))
                                {
                                    DSWT (0x02)
                                }
                                Else
                                {
                                    DSWT (0x01)
                                }
                            }
                        }
                        Method (_DDC, 1, NotSerialized)
                        {
                            If (ISOP ())
                            {
                                Return (0x00)
                            }
                            If (LEqual (Arg0, 0x01))
                            {
                                Return (\VEDI)
                            }
                            Else
                            {
                                If (LEqual (Arg0, 0x02))
                                {
                                    Return (\VEDI)
                                }
                            }
                            Return (0x00)
                        }
                    }
                    Device (CRT0)
                    {
                        Method (_ADR, 0, NotSerialized)
                        {
                            Return (0x0100)
                        }
                        Method (_DCS, 0, NotSerialized)
                        {
                            \VUPS (0x01)
                            If (\VCSS)
                            {
                                If (\VCDC)
                                {
                                    Return (0x1F)
                                }
                                Else
                                {
                                    Return (0x1D)
                                }
                            }
                            Else
                            {
                                If (\VCDC)
                                {
                                    Return (0x0F)
                                }
                                Else
                                {
                                    Return (0x0D)
                                }
                            }
                        }
                        Method (_DGS, 0, NotSerialized)
                        {
                            Return (VQDC)
                        }
                        Method (_DSS, 1, NotSerialized)
                        {
                            And (Arg0, 0x01, VSDC)
                            If (And (Arg0, 0x80000000))
                            {
                                If (And (Arg0, 0x40000000))
                                {
                                    DSWT (0x02)
                                }
                                Else
                                {
                                    DSWT (0x01)
                                }
                            }
                        }
                    }
                    Device (DVI0)
                    {
                        Method (_ADR, 0, NotSerialized)
                        {
                            Return (0x0111)
                        }
                        Method (_DCS, 0, NotSerialized)
                        {
                            \VUPS (0x00)
                            If (\VCDD)
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x1D)
                            }
                        }
                        Method (_DGS, 0, NotSerialized)
                        {
                            Return (VQD1)
                        }
                        Method (_DSS, 1, NotSerialized)
                        {
                            And (Arg0, 0x01, VSD1)
                            If (And (Arg0, 0x80000000))
                            {
                                If (And (Arg0, 0x40000000))
                                {
                                    DSWT (0x02)
                                }
                                Else
                                {
                                    DSWT (0x01)
                                }
                            }
                        }
                    }
                    Device (DP0)
                    {
                        Method (_ADR, 0, NotSerialized)
                        {
                            Return (0x0114)
                        }
                        Method (_DCS, 0, NotSerialized)
                        {
                            \VUPS (0x00)
                            If (\VCDT)
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x1D)
                            }
                        }
                        Method (_DGS, 0, NotSerialized)
                        {
                            Return (VQD0)
                        }
                        Method (_DSS, 1, NotSerialized)
                        {
                            And (Arg0, 0x01, VSD0)
                            If (And (Arg0, 0x80000000))
                            {
                                If (And (Arg0, 0x40000000))
                                {
                                    DSWT (0x02)
                                }
                                Else
                                {
                                    DSWT (0x01)
                                }
                            }
                        }
                    }
                    Device (DVI1)
                    {
                        Method (_ADR, 0, NotSerialized)
                        {
                            Return (0x0112)
                        }
                        Method (_DCS, 0, NotSerialized)
                        {
                            \VUPS (0x00)
                            If (\VCDD)
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x1D)
                            }
                        }
                        Method (_DGS, 0, NotSerialized)
                        {
                            Return (VQD3)
                        }
                        Method (_DSS, 1, NotSerialized)
                        {
                            And (Arg0, 0x01, VSD3)
                            If (And (Arg0, 0x80000000))
                            {
                                If (And (Arg0, 0x40000000))
                                {
                                    DSWT (0x02)
                                }
                                Else
                                {
                                    DSWT (0x01)
                                }
                            }
                        }
                    }
                    Device (DP1)
                    {
                        Method (_ADR, 0, NotSerialized)
                        {
                            Return (0x0115)
                        }
                        Method (_DCS, 0, NotSerialized)
                        {
                            \VUPS (0x00)
                            If (\VCDT)
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x1D)
                            }
                        }
                        Method (_DGS, 0, NotSerialized)
                        {
                            Return (VQD2)
                        }
                        Method (_DSS, 1, NotSerialized)
                        {
                            And (Arg0, 0x01, VSD2)
                            If (And (Arg0, 0x80000000))
                            {
                                If (And (Arg0, 0x40000000))
                                {
                                    DSWT (0x02)
                                }
                                Else
                                {
                                    DSWT (0x01)
                                }
                            }
                        }
                    }
                    Device (DVI2)
                    {
                        Method (_ADR, 0, NotSerialized)
                        {
                            Return (0x0113)
                        }
                        Method (_DCS, 0, NotSerialized)
                        {
                            \VUPS (0x00)
                            If (\VCDD)
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x1D)
                            }
                        }
                        Method (_DGS, 0, NotSerialized)
                        {
                            Return (VQD5)
                        }
                        Method (_DSS, 1, NotSerialized)
                        {
                            And (Arg0, 0x01, VSD5)
                            If (And (Arg0, 0x80000000))
                            {
                                If (And (Arg0, 0x40000000))
                                {
                                    DSWT (0x02)
                                }
                                Else
                                {
                                    DSWT (0x01)
                                }
                            }
                        }
                    }
                    Device (DP2)
                    {
                        Method (_ADR, 0, NotSerialized)
                        {
                            Return (0x0116)
                        }
                        Method (_DCS, 0, NotSerialized)
                        {
                            \VUPS (0x00)
                            If (\VCDT)
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x1D)
                            }
                        }
                        Method (_DGS, 0, NotSerialized)
                        {
                            Return (VQD4)
                        }
                        Method (_DSS, 1, NotSerialized)
                        {
                            And (Arg0, 0x01, VSD4)
                            If (And (Arg0, 0x80000000))
                            {
                                If (And (Arg0, 0x40000000))
                                {
                                    DSWT (0x02)
                                }
                                Else
                                {
                                    DSWT (0x01)
                                }
                            }
                        }
                    }
                    Method (DSWT, 1, NotSerialized)
                    {
                        If (VSDL)
                        {
                            Store (0x01, Local0)
                        }
                        Else
                        {
                            Store (0x00, Local0)
                        }
                        If (VSDC)
                        {
                            Or (0x02, Local0, Local0)
                        }
                        If (VSD0)
                        {
                            Or (0x08, Local0, Local0)
                        }
                        If (Local0)
                        {
                            If (VUPC)
                            {
                                \VSDS (Local0, Arg0)
                            }
                        }
                        Else
                        {
                            Noop
                        }
                    }
                }
                OperationRegion (PEGC, PCI_Config, 0x00, 0x0100)
                Field (PEGC, DWordAcc, NoLock, Preserve)
                {
                    Offset (0xEC), 
                    GMGP,   1, 
                    HPGP,   1, 
                    PMGP,   1
                }
            }
            Device (IGBE)
            {
                Name (_ADR, 0x00190000)
                Name (_S3D, 0x03)
                Name (RID, 0x00)
                Name (_PRW, Package (0x02)
                {
                    0x0D, 
                    0x04
                })
            }
            Device (EXP1)
            {
                Name (_ADR, 0x001C0000)
                Name (RID, 0x00)
                OperationRegion (PECS, PCI_Config, 0x00, 0x0100)
                Field (PECS, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x62), 
                    PS,     1, 
                    PP,     1, 
                    Offset (0xDB), 
                        ,   7, 
                    PMCE,   1, 
                    Offset (0xDF), 
                        ,   7, 
                    PMCS,   1
                }
                Name (LPRT, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        \_SB.LNKA, 
                        0x00
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        \_SB.LNKB, 
                        0x00
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        \_SB.LNKC, 
                        0x00
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        \_SB.LNKD, 
                        0x00
                    }
                })
                Name (APRT, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        0x00, 
                        0x10
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        0x00, 
                        0x11
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        0x00, 
                        0x12
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        0x00, 
                        0x13
                    }
                })
                Method (_PRT, 0, NotSerialized)
                {
                    If (\GPIC)
                    {
                        Return (APRT)
                    }
                    Else
                    {
                        Return (LPRT)
                    }
                }
            }
            Device (EXP2)
            {
                Name (_ADR, 0x001C0001)
                Name (RID, 0x00)
                OperationRegion (PECS, PCI_Config, 0x00, 0x0100)
                Field (PECS, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x62), 
                    PS,     1, 
                    PP,     1, 
                    Offset (0xDB), 
                        ,   7, 
                    PMCE,   1, 
                    Offset (0xDF), 
                        ,   7, 
                    PMCS,   1
                }
                Name (LPRT, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        \_SB.LNKB, 
                        0x00
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        \_SB.LNKC, 
                        0x00
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        \_SB.LNKD, 
                        0x00
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        \_SB.LNKA, 
                        0x00
                    }
                })
                Name (APRT, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        0x00, 
                        0x11
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        0x00, 
                        0x12
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        0x00, 
                        0x13
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        0x00, 
                        0x10
                    }
                })
                Method (_PRT, 0, NotSerialized)
                {
                    If (\GPIC)
                    {
                        Return (APRT)
                    }
                    Else
                    {
                        Return (LPRT)
                    }
                }
            }
            Device (EXP4)
            {
                Name (_ADR, 0x001C0003)
                Name (RID, 0x00)
                OperationRegion (PECS, PCI_Config, 0x00, 0x0100)
                Field (PECS, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x5A), 
                        ,   3, 
                    PDC,    1, 
                        ,   2, 
                    PDS,    1, 
                    Offset (0x5B), 
                    Offset (0x62), 
                    PS,     1, 
                    PP,     1, 
                    Offset (0xDB), 
                        ,   6, 
                    HPCE,   1, 
                    PMCE,   1, 
                    Offset (0xDF), 
                        ,   6, 
                    HPCS,   1, 
                    PMCS,   1
                }
                Method (_INI, 0, NotSerialized)
                {
                    Store (PDS, PDSF)
                }
                Name (_PRW, Package (0x02)
                {
                    0x09, 
                    0x04
                })
                Name (LPRT, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        \_SB.LNKD, 
                        0x00
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        \_SB.LNKA, 
                        0x00
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        \_SB.LNKB, 
                        0x00
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        \_SB.LNKC, 
                        0x00
                    }
                })
                Name (APRT, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        0x00, 
                        0x13
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        0x00, 
                        0x10
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        0x00, 
                        0x11
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        0x00, 
                        0x12
                    }
                })
                Method (_PRT, 0, NotSerialized)
                {
                    If (\GPIC)
                    {
                        Return (APRT)
                    }
                    Else
                    {
                        Return (LPRT)
                    }
                }
                Name (PDSF, 0x00)
                Device (SLOT)
                {
                    Name (_ADR, 0x00)
                    Method (_RMV, 0, NotSerialized)
                    {
                        Return (0x01)
                    }
                }
            }
            Device (EXP5)
            {
                Name (_ADR, 0x001C0004)
                Name (RID, 0x00)
                OperationRegion (PECS, PCI_Config, 0x00, 0x0100)
                Field (PECS, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x5A), 
                        ,   3, 
                    PDC,    1, 
                        ,   2, 
                    PDS,    1, 
                    Offset (0x5B), 
                    Offset (0x62), 
                    PS,     1, 
                    PP,     1, 
                    Offset (0xDB), 
                        ,   6, 
                    HPCE,   1, 
                    PMCE,   1, 
                    Offset (0xDF), 
                        ,   6, 
                    HPCS,   1, 
                    PMCS,   1
                }
                Method (_INI, 0, NotSerialized)
                {
                    Store (PDS, PDSF)
                }
                Name (LPRT, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        \_SB.LNKA, 
                        0x00
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        \_SB.LNKB, 
                        0x00
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        \_SB.LNKC, 
                        0x00
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        \_SB.LNKD, 
                        0x00
                    }
                })
                Name (APRT, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        0x00, 
                        0x10
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        0x00, 
                        0x11
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        0x00, 
                        0x12
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        0x00, 
                        0x13
                    }
                })
                Method (_PRT, 0, NotSerialized)
                {
                    If (\GPIC)
                    {
                        Return (APRT)
                    }
                    Else
                    {
                        Return (LPRT)
                    }
                }
                Name (PDSF, 0x00)
                Device (SLOT)
                {
                    Name (_ADR, 0x00)
                }
            }
            Device (EXP7)
            {
                Name (_ADR, 0x001C0006)
                Name (RID, 0x00)
                OperationRegion (PECS, PCI_Config, 0x00, 0x0100)
                Field (PECS, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x62), 
                    PS,     1, 
                    PP,     1, 
                    Offset (0xDB), 
                        ,   7, 
                    PMCE,   1, 
                    Offset (0xDF), 
                        ,   7, 
                    PMCS,   1
                }
                Name (_PRW, Package (0x02)
                {
                    0x09, 
                    0x04
                })
                Name (LPRT, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        \_SB.LNKC, 
                        0x00
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        \_SB.LNKD, 
                        0x00
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        \_SB.LNKA, 
                        0x00
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        \_SB.LNKB, 
                        0x00
                    }
                })
                Name (APRT, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        0x00, 
                        0x12
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x01, 
                        0x00, 
                        0x13
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        0x00, 
                        0x10
                    }, 
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        0x00, 
                        0x11
                    }
                })
                Method (_PRT, 0, NotSerialized)
                {
                    If (\GPIC)
                    {
                        Return (APRT)
                    }
                    Else
                    {
                        Return (LPRT)
                    }
                }
            }
            Device (SAT1)
            {
                Name (_ADR, 0x001F0002)
                Name (_S3D, 0x03)
                Name (RID, 0x00)
            }
            Device (SAT2)
            {
                Name (_ADR, 0x001F0005)
                Name (_S3D, 0x03)
                Name (RID, 0x00)
            }
            Device (SMBU)
            {
                Name (_ADR, 0x001F0003)
                Name (_S3D, 0x03)
                Name (RID, 0x00)
            }
            Device (EHC1)
            {
                Name (_ADR, 0x001D0000)
                Name (_S3D, 0x03)
                Name (RID, 0x00)
                OperationRegion (EHCS, PCI_Config, 0x00, 0x0100)
                Field (EHCS, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x62), 
                    PWKI,   1, 
                    PWUC,   8, 
                    Offset (0x64)
                }
                Name (_PR0, Package (0x01)
                {
                    \_SB.PCI0.LPC.EC.PUBS
                })
                Name (_PR1, Package (0x01)
                {
                    \_SB.PCI0.LPC.EC.PUBS
                })
                Name (_PR2, Package (0x01)
                {
                    \_SB.PCI0.LPC.EC.PUBS
                })
                Method (_INI, 0, NotSerialized)
                {
                    Store (0x01, PWKI)
                    Store (0x23, PWUC)
                }
                Name (_PRW, Package (0x03)
                {
                    0x0D, 
                    0x03, 
                    \_SB.PCI0.LPC.EC.PUBS
                })
                Device (URTH)
                {
                    Name (_ADR, 0x00)
                    Device (URMH)
                    {
                        Name (_ADR, 0x01)
                        Name (_UPC, Package (0x04)
                        {
                            0xFF, 
                            0xFF, 
                            0x00, 
                            0x00
                        })
                        Name (_PLD, Package (0x10)
                        {
                            /* 0000 */   0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                            /* 0008 */   0x30, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                        })
                        Device (PRT0)
                        {
                            Name (_ADR, 0x01)
                            Name (_UPC, Package (0x04)
                            {
                                0xFF, 
                                0x00, 
                                0x00, 
                                0x00
                            })
                            Name (_PLD, Package (0x10)
                            {
                                /* 0000 */   0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                /* 0008 */   0x59, 0x0E, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00
                            })
                        }
                        Device (PRT1)
                        {
                            Name (_ADR, 0x02)
                            Name (_UPC, Package (0x04)
                            {
                                0xFF, 
                                0x00, 
                                0x00, 
                                0x00
                            })
                            Name (_PLD, Package (0x10)
                            {
                                /* 0000 */   0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                /* 0008 */   0x11, 0x12, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00
                            })
                        }
                        Device (PRT2)
                        {
                            Name (_ADR, 0x03)
                            Name (_UPC, Package (0x04)
                            {
                                0xFF, 
                                0xFF, 
                                0x00, 
                                0x00
                            })
                            Name (_PLD, Package (0x10)
                            {
                                /* 0000 */   0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                /* 0008 */   0x30, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            })
                        }
                        Device (PRT3)
                        {
                            Name (_ADR, 0x04)
                            Name (_UPC, Package (0x04)
                            {
                                0xFF, 
                                0xFF, 
                                0x00, 
                                0x00
                            })
                            Name (_PLD, Package (0x10)
                            {
                                /* 0000 */   0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                /* 0008 */   0x30, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            })
                        }
                        Device (PRT4)
                        {
                            Name (_ADR, 0x05)
                            Name (_UPC, Package (0x04)
                            {
                                0xFF, 
                                0xFF, 
                                0x00, 
                                0x00
                            })
                            Name (_PLD, Package (0x10)
                            {
                                /* 0000 */   0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                /* 0008 */   0x30, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            })
                        }
                        Device (PRT5)
                        {
                            Name (_ADR, 0x06)
                            Name (_UPC, Package (0x04)
                            {
                                0xFF, 
                                0x02, 
                                0x00, 
                                0x00
                            })
                            Name (_PLD, Package (0x10)
                            {
                                /* 0000 */   0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                /* 0008 */   0x19, 0x10, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00
                            })
                        }
                        Device (PRT6)
                        {
                            Name (_ADR, 0x07)
                            Name (_UPC, Package (0x04)
                            {
                                0xFF, 
                                0xFF, 
                                0x00, 
                                0x00
                            })
                            Name (_PLD, Package (0x10)
                            {
                                /* 0000 */   0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                /* 0008 */   0x30, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            })
                        }
                        Device (PRT7)
                        {
                            Name (_ADR, 0x08)
                            Name (_UPC, Package (0x04)
                            {
                                0xFF, 
                                0xFF, 
                                0x00, 
                                0x00
                            })
                            Name (_PLD, Package (0x10)
                            {
                                /* 0000 */   0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                /* 0008 */   0x30, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            })
                        }
                    }
                }
                Method (_DSM, 4, NotSerialized)
                {
                    Store (Package ()
                        {
                            "device-id", 
                            Buffer (0x04)
                            {
                                0x26, 0x1c, 0x00, 0x00
                            }, 
                            "built-in", 
                            Buffer (One)
                            {
                                0x00
                            }, 
                            "AAPL,clock-id", 
                            Buffer (One)
                            {
                                0x01
                            }, 
                            "device_type", 
                            Buffer (0x05)
                            {
                                "EHCI"
                            }, 
                            "AAPL,current-available", 
                            0x0834, 
                            "AAPL,current-extra", 
                            0x0898, 
                            "AAPL,current-extra-in-sleep", 
                            0x0640, 
                            "AAPL,device-internal",
                            0x02,
                            "AAPL,max-port-current-in-sleep",
                            0x0834,  
                            Buffer (One)
                            {
                                0x00
                            }
                        }, Local0)
                    DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                    Return (Local0)
                }
            }
            Device (EHC2)
            {
                Name (_ADR, 0x001A0000)
                Name (_S3D, 0x03)
                Name (RID, 0x00)
                OperationRegion (EHCS, PCI_Config, 0x00, 0x0100)
                Field (EHCS, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x62), 
                    PWKI,   1, 
                    PWUC,   6, 
                    Offset (0x64)
                }
                Name (_PR0, Package (0x01)
                {
                    \_SB.PCI0.LPC.EC.PUBS
                })
                Name (_PR1, Package (0x01)
                {
                    \_SB.PCI0.LPC.EC.PUBS
                })
                Name (_PR2, Package (0x01)
                {
                    \_SB.PCI0.LPC.EC.PUBS
                })
                Method (_INI, 0, NotSerialized)
                {
                    Store (0x01, PWKI)
                    Store (0x13, PWUC)
                }
                Name (_PRW, Package (0x03)
                {
                    0x0D, 
                    0x03, 
                    \_SB.PCI0.LPC.EC.PUBS
                })
                Device (URTH)
                {
                    Name (_ADR, 0x00)
                    Device (URMH)
                    {
                        Name (_ADR, 0x01)
                        Name (_UPC, Package (0x04)
                        {
                            0xFF, 
                            0xFF, 
                            0x00, 
                            0x00
                        })
                        Name (_PLD, Package (0x10)
                        {
                            /* 0000 */   0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                            /* 0008 */   0x30, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                        })
                        Device (PRT8)
                        {
                            Name (_ADR, 0x01)
                            Name (_UPC, Package (0x04)
                            {
                                0xFF, 
                                0x00, 
                                0x00, 
                                0x00
                            })
                            Name (_PLD, Package (0x10)
                            {
                                /* 0000 */   0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                /* 0008 */   0x30, 0x11, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            })
                        }
                        Device (PRT9)
                        {
                            Name (_ADR, 0x02)
                            Name (_UPC, Package (0x04)
                            {
                                0xFF, 
                                0x00, 
                                0x00, 
                                0x00
                            })
                            Name (_PLD, Package (0x10)
                            {
                                /* 0000 */   0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                /* 0008 */   0x91, 0x12, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00
                            })
                        }
                        Device (PRTA)
                        {
                            Name (_ADR, 0x03)
                            Name (_UPC, Package (0x04)
                            {
                                0xFF, 
                                0xFF, 
                                0x00, 
                                0x00
                            })
                            Name (_PLD, Package (0x10)
                            {
                                /* 0000 */   0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                /* 0008 */   0x30, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            })
                        }
                        Device (PRTB)
                        {
                            Name (_ADR, 0x04)
                            Name (_UPC, Package (0x04)
                            {
                                0xFF, 
                                0xFF, 
                                0x00, 
                                0x00
                            })
                            Name (_PLD, Package (0x10)
                            {
                                /* 0000 */   0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                /* 0008 */   0x30, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            })
                        }
                        Device (PRTC)
                        {
                            Name (_ADR, 0x05)
                            Name (_UPC, Package (0x04)
                            {
                                0xFF, 
                                0x00, 
                                0x00, 
                                0x00
                            })
                            Name (_PLD, Package (0x10)
                            {
                                /* 0000 */   0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                /* 0008 */   0x69, 0x11, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00
                            })
                        }
                        Device (PRTD)
                        {
                            Name (_ADR, 0x06)
                            Name (_UPC, Package (0x04)
                            {
                                0xFF, 
                                0xFF, 
                                0x00, 
                                0x00
                            })
                            Name (_PLD, Package (0x10)
                            {
                                /* 0000 */   0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                /* 0008 */   0x30, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                            })
                        }
                    }
                }
                Method (_DSM, 4, NotSerialized)
                {
                    Store (Package ()
                        {
                            "device-id", 
                            Buffer (0x04)
                            {
                                0x26, 0x1c, 0x00, 0x00
                            }, 
                            "built-in", 
                            Buffer (One)
                            {
                                0x00
                            }, 
                            "AAPL,clock-id", 
                            Buffer (One)
                            {
                                0x02
                            }, 
                            "device_type", 
                            Buffer (0x05)
                            {
                                "EHCI"
                            }, 
                            "AAPL,current-available", 
                            0x0834, 
                            "AAPL,current-extra", 
                            0x0898, 
                            "AAPL,current-extra-in-sleep", 
                            0x0640, 
                            "AAPL,device-internal",
                            0x02,
                            "AAPL,max-port-current-in-sleep",
                            0x0834,  
                            Buffer (One)
                            {
                                0x00
                            }
                        }, Local0)
                    DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                    Return (Local0)
                }
            }
	    Device (HDEF)
	    {
		    Name (_ADR, 0x001B0000)
			    Name (_S3D, 0x03)
			    Name (RID, Zero)
			    Name (_PRW, Package (0x02)
					    {
					    0x0D,
					    0x04
					    })
				Method (_DSM, 4, NotSerialized)
				{
					Store (Package (0x0E)
							{
							"AAPL,slot-name",
							Buffer (0x09)
							{
							"Built in"
							},
							"device-id",
							Buffer (0x04)
							{
							0x6e, 0x50, 0xF1, 0x14
							},
							"layout-id",
							Buffer (0x04)
							{
							0x0C, 0x00, 0x00, 0x00
							},
							"model",
							Buffer (0x1A)
							{
							"HD Audio Conexant Cx20590"
							},
							"name",
							Buffer (0x11)
							{
								"Conexant Cx20590"
							},
							"device_type",
							Buffer (0x11)
							{
								"Audio Controller"
							},
							"PinConfigurations",
							Buffer (One)
							{
								0x00
							}
							}, Local0)
					DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
						Return (Local0)
				}
	    }
        }
        Scope (\_SB.PCI0.LPC.EC)
        {
            Name (BDEV, 0xFF)
            Name (BSTS, 0x00)
            Name (BHKE, 0x00)
            Method (_Q2C, 0, NotSerialized)
            {
                If (LEqual (BSTS, 0x00))
                {
                    Store (BGID (0x00), BDEV)
                    NBRE (BDEV)
                }
            }
            Method (_Q2D, 0, NotSerialized)
            {
                Store (BGID (0x00), BDEV)
                NBIN (BDEV)
            }
            Method (_Q38, 0, NotSerialized)
            {
                Store (BGID (0x00), Local0)
                If (LEqual (Local0, 0x0F))
                {
                    BDIS ()
                    \BHDP (0x01, 0x00)
                    NBEJ (BDEV)
                    Store (Local0, BDEV)
                    If (LEqual (\BIDE, 0x03))
                    {
                        Store (0x00, \_SB.PCI0.SAT1.PRIM.GTME)
                        Store (0x00, \_SB.PCI0.SAT1.SCND.GTME)
                    }
                }
                Else
                {
                    If (HPBU) {}
                    Else
                    {
                        Store (Local0, BDEV)
                        NBIN (Local0)
                    }
                }
            }
            Name (ODEJ, 0x00)
            Method (_Q44, 0, NotSerialized)
            {
                If (\_SB.PCI0.LPC.CSON)
                {
                    Store (0x01, ODEJ)
                    Store (BGID (0x00), BDEV)
                    NBIN (BDEV)
                    Store (0x00, ODEJ)
                    \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x3006)
                }
            }
            Method (NBRE, 1, NotSerialized)
            {
                If (LLess (Arg0, 0x0C))
                {
                    If (LEqual (\BIDE, 0x03))
                    {
                        Notify (\_SB.PCI0.SAT1.SCND.MSTR, 0x03)
                    }
                    Else
                    {
                        Notify (\_SB.PCI0.SAT1.PRT1, 0x03)
                    }
                }
            }
            Method (NBEJ, 1, NotSerialized)
            {
                If (LEqual (BSTS, 0x00))
                {
                    If (LLess (Arg0, 0x0C))
                    {
                        If (LEqual (\BIDE, 0x03))
                        {
                            Notify (\_SB.PCI0.SAT1.SCND.MSTR, 0x01)
                        }
                        Else
                        {
                            Notify (\_SB.PCI0.SAT1.PRT1, 0x01)
                        }
                    }
                }
                BEEP (0x00)
                Store (0x00, BSTS)
            }
            Method (NBIN, 1, NotSerialized)
            {
                If (LLess (Arg0, 0x0C))
                {
                    BEN (0x01)
                    If (LEqual (\BIDE, 0x03))
                    {
                        Notify (\_SB.PCI0.SAT1.SCND.MSTR, 0x01)
                    }
                    Else
                    {
                        Notify (\_SB.PCI0.SAT1.PRT1, 0x01)
                    }
                }
                BEEP (0x00)
                Store (0x00, BSTS)
            }
            Method (BEJ0, 1, NotSerialized)
            {
                If (Arg0)
                {
                    BDIS ()
                    \BHDP (0x01, 0x00)
                    Store (0x01, BSTS)
                    If (BHKE)
                    {
                        Store (0x00, BHKE)
                        \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x3003)
                    }
                }
                Else
                {
                    Store (0x00, BSTS)
                }
            }
            Method (BEJ3, 1, NotSerialized)
            {
                If (Arg0)
                {
                    BDIS ()
                    Store (0x01, BSTS)
                }
                Else
                {
                    Store (0x00, BSTS)
                }
            }
            Method (BPTS, 1, NotSerialized)
            {
                Store (0x01, HDBM)
                If (LNotEqual (BSTS, 0x00))
                {
                    Store (0x0F, BDEV)
                    Store (0x00, BSTS)
                }
                Store (0x00, BHKE)
                BUWK (0x00)
            }
            Method (BWAK, 1, NotSerialized)
            {
                BUWK (0x00)
                Store (BGID (0x00), Local0)
                If (LEqual (BSTS, 0x00))
                {
                    If (LNotEqual (Local0, BDEV))
                    {
                        NBEJ (BDEV)
                        Store (Local0, BDEV)
                        NBIN (Local0)
                    }
                    Else
                    {
                        If (LOr (\LFDC, LNotEqual (BDEV, 0x0D)))
                        {
                            If (LNotEqual (Local0, 0x0F))
                            {
                                If (HPBU)
                                {
                                    If (LLessEqual (Arg0, 0x02)) {}
                                    Else
                                    {
                                        NBRE (Local0)
                                    }
                                }
                            }
                        }
                    }
                }
                If (LLess (BDEV, 0x0C))
                {
                    Store (0x00, \_SB.PCI0.LPC.GLIS)
                }
                Else
                {
                    Store (0x01, \_SB.PCI0.LPC.GLIS)
                }
            }
            Method (BDIS, 0, NotSerialized)
            {
                If (LNot (\_SB.PCI0.LPC.CSON))
                {
                    If (LNot (\_SB.PCI0.LPC.GLIS))
                    {
                        Store (0x01, \_SB.PCI0.LPC.GLIS)
                    }
                    Store (0x01, \_SB.PCI0.LPC.CSON)
                    Store (0x0F, \IDET)
                }
            }
            Method (BPON, 1, NotSerialized)
            {
                If (\_SB.PCI0.LPC.CSON)
                {
                    Store (0x00, \_SB.PCI0.LPC.CSON)
                    If (\_SB.PCI0.LPC.GLIS)
                    {
                        Store (0x00, \_SB.PCI0.LPC.GLIS)
                    }
                }
            }
            Method (BEN, 1, NotSerialized)
            {
                If (\_SB.PCI0.LPC.CSON)
                {
                    BPON (Arg0)
                    If (LAnd (Arg0, LEqual (ODEJ, 0x01)))
                    {
                        Store (0x09, \_SB.PCI0.LPC.EC.HANT)
                    }
                    If (Arg0)
                    {
                        IRDY ()
                    }
                }
            }
            Method (BSTA, 1, NotSerialized)
            {
                If (\_SB.PCI0.LPC.CSON)
                {
                    Return (0x00)
                }
                BINI ()
                If (LEqual (Arg0, 0x01))
                {
                    Return (LLess (BDEV, 0x0C))
                }
                Return (0x00)
            }
            Method (BUWK, 1, NotSerialized)
            {
                If (\H8DR)
                {
                    If (Arg0)
                    {
                        Store (0x01, \_SB.PCI0.LPC.EC.HWBU)
                    }
                    Else
                    {
                        Store (0x00, \_SB.PCI0.LPC.EC.HWBU)
                    }
                }
                Else
                {
                    If (Arg0)
                    {
                        \MBEC (0x32, 0xFF, 0x80)
                    }
                    Else
                    {
                        \MBEC (0x32, 0x7F, 0x00)
                    }
                }
            }
            Method (BINI, 0, NotSerialized)
            {
                If (LEqual (BDEV, 0xFF))
                {
                    Store (BGID (0x00), BDEV)
                }
            }
            Method (BGID, 1, NotSerialized)
            {
                If (Arg0)
                {
                    Store (0xFF, Local0)
                }
                Else
                {
                    If (\H8DR)
                    {
                        Store (HPBU, Local1)
                        Store (HBID, Local2)
                    }
                    Else
                    {
                        Store (RBEC (0x47), Local2)
                        And (Local2, 0x01, Local1)
                        And (Local2, 0x04, Local2)
                        ShiftRight (Local2, 0x02, Local2)
                    }
                    If (Local2)
                    {
                        Store (0x0F, Local0)
                    }
                    Else
                    {
                        If (HDUB)
                        {
                            Store (0x0F, Local0)
                        }
                        Else
                        {
                            If (LOr (LEqual (\IDET, 0x03), LEqual (\IDET, 0x06)))
                            {
                                Store (\IDET, Local0)
                            }
                            Else
                            {
                                Store (0x07, Local0)
                            }
                        }
                    }
                    If (LEqual (Local0, 0x0F)) {}
                }
                If (LAnd (\HDUB, LLess (Local0, 0x0C)))
                {
                    Store (0x0F, Local0)
                }
                Return (Local0)
            }
            Method (IRDY, 0, NotSerialized)
            {
                Store (0x01F4, Local0)
                Store (0x3C, Local1)
                Store (Zero, Local2)
                While (Local1)
                {
                    Sleep (Local0)
                    Store (\BCHK (), Local3)
                    If (LNot (Local3))
                    {
                        Break
                    }
                    If (LEqual (Local3, 0x02))
                    {
                        Store (One, Local2)
                        Break
                    }
                    Decrement (Local1)
                }
                Return (Local2)
            }
        }
        Scope (\_SB.PCI0.LPC.EC)
        {
            Method (_Q43, 0, NotSerialized)
            {
                \UCMS (0x18)
            }
            Method (SAUM, 1, NotSerialized)
            {
                If (LGreater (Arg0, 0x03))
                {
                    Noop
                }
                Else
                {
                    If (\H8DR)
                    {
                        Store (Arg0, HAUM)
                    }
                    Else
                    {
                        \MBEC (0x03, 0x9F, ShiftLeft (Arg0, 0x05))
                    }
                }
            }
        }
        Scope (\_SB.PCI0.LPC.EC.HKEY)
        {
            Method (GSMS, 1, NotSerialized)
            {
                Return (\AUDC (0x00, 0x00))
            }
            Method (SSMS, 1, NotSerialized)
            {
                Return (\AUDC (0x01, And (Arg0, 0x01)))
            }
            Method (SHDA, 1, NotSerialized)
            {
                Return (\AUDC (0x02, And (Arg0, 0x01)))
            }
        }
        Scope (\_SB.PCI0.LPC.EC)
        {
            Name (BRTW, Package (0x12)
            {
                0x64, 
                0x64, 
                0x0A, 
                0x0F, 
                0x14, 
                0x19, 
                0x1E, 
                0x23, 
                0x28, 
                0x2D, 
                0x32, 
                0x37, 
                0x3C, 
                0x41, 
                0x46, 
                0x50, 
                0x5A, 
                0x64
            })
            Name (BRTB, Package (0x04)
            {
                Package (0x16)
                {
                    0x16, 
                    0x04, 
                    0x03, 
                    0x05, 
                    0x08, 
                    0x0A, 
                    0x0D, 
                    0x12, 
                    0x19, 
                    0x21, 
                    0x2B, 
                    0x38, 
                    0x4A, 
                    0x61, 
                    0x7E, 
                    0xA0, 
                    0xCC, 
                    0xFF, 
                    0xDC, 
                    0xDC, 
                    0x03, 
                    0x03
                }, 
                Package (0x16)
                {
                    0x1B, 
                    0x04, 
                    0x03, 
                    0x05, 
                    0x08, 
                    0x0A, 
                    0x0D, 
                    0x0F, 
                    0x12, 
                    0x19, 
                    0x22, 
                    0x2E, 
                    0x3E, 
                    0x54, 
                    0x6E, 
                    0x93, 
                    0xC1, 
                    0xFF, 
                    0xDC, 
                    0xDC, 
                    0x03, 
                    0x03
                }, 
                Package (0x16)
                {
                    0x00, 
                    0x04, 
                    0x04, 
                    0x07, 
                    0x09, 
                    0x0C, 
                    0x10, 
                    0x15, 
                    0x1C, 
                    0x25, 
                    0x32, 
                    0x40, 
                    0x50, 
                    0x64, 
                    0x82, 
                    0xA5, 
                    0xCD, 
                    0xFF, 
                    0xDC, 
                    0xDC, 
                    0x04, 
                    0x04
                }, 
                Package (0x16)
                {
                    0x00, 
                    0x04, 
                    0x04, 
                    0x07, 
                    0x09, 
                    0x0C, 
                    0x10, 
                    0x15, 
                    0x1C, 
                    0x25, 
                    0x32, 
                    0x40, 
                    0x50, 
                    0x64, 
                    0x82, 
                    0xA5, 
                    0xCD, 
                    0xFF, 
                    0xDC, 
                    0xDC, 
                    0x04, 
                    0x04
                }
            })
            Method (_Q14, 0, NotSerialized)
            {
                If (\_SB.PCI0.LPC.EC.HKEY.MHKK (0x8000))
                {
                    \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x1010)
                }
                If (\NBCF)
                {
                    If (\VIGD)
                    {
                        Notify (\_SB.PCI0.VID.LCD0, 0x86)
                    }
                    Else
                    {
                        Notify (\_SB.PCI0.PEG.VID.LCD0, 0x86)
                    }
                }
                Else
                {
                    Store (\BRLV, Local0)
                    If (LNotEqual (Local0, 0x0F))
                    {
                        Increment (Local0)
                        Store (Local0, \BRLV)
                    }
                    If (\VIGD)
                    {
                        \UCMS (0x16)
                        \_SB.PCI0.LPC.EC.BRNS ()
                    }
                    Else
                    {
                        \VBRC (Local0)
                    }
                    \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x6050)
                }
            }
            Method (_Q15, 0, NotSerialized)
            {
                If (\_SB.PCI0.LPC.EC.HKEY.MHKK (0x00010000))
                {
                    \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x1011)
                }
                If (\NBCF)
                {
                    If (\VIGD)
                    {
                        Notify (\_SB.PCI0.VID.LCD0, 0x87)
                    }
                    Else
                    {
                        Notify (\_SB.PCI0.PEG.VID.LCD0, 0x87)
                    }
                }
                Else
                {
                    Store (\BRLV, Local0)
                    If (Local0)
                    {
                        Decrement (Local0)
                        Store (Local0, \BRLV)
                    }
                    If (\VIGD)
                    {
                        \UCMS (0x16)
                        \_SB.PCI0.LPC.EC.BRNS ()
                    }
                    Else
                    {
                        \VBRC (Local0)
                    }
                    \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x6050)
                }
                Return (Zero)
            }
            Method (BRNS, 0, NotSerialized)
            {
                Add (\BRLV, 0x02, Local0)
                Store (\BRTN, Local3)
                If (\_SB.PCI0.VID.DRDY)
                {
                    If (LEqual (0x00, Local0))
                    {
                        Store (DerefOf (Index (DerefOf (Index (BRTB, Local3)), 0x14)), 
                            Local1)
                        Store (DerefOf (Index (DerefOf (Index (BRTB, Local3)), 0x12)), 
                            Local2)
                    }
                    Else
                    {
                        Store (DerefOf (Index (DerefOf (Index (BRTB, Local3)), 0x15)), 
                            Local1)
                        Store (DerefOf (Index (DerefOf (Index (BRTB, Local3)), 0x13)), 
                            Local2)
                    }
                    Or (Local1, ShiftLeft (Local2, 0x09), Local2)
                    \_SB.PCI0.VID.AINT (0x03, Local2)
                    Store (DerefOf (Index (DerefOf (Index (BRTB, Local3)), Local0)), 
                        Local2)
                    \_SB.PCI0.VID.AINT (0x01, Local2)
                }
                Else
                {
                    \UCMS (0x12)
                }
            }
        }
        Scope (\_SB.PCI0.LPC.EC)
        {
            Method (_Q19, 0, NotSerialized)
            {
                Name (FANS, One)
                Store (HFSP, FANS)
                XOr (FANS, 0x40, Local0)
                If (Local0)
                {
                    LED (0xFF, 0x80)
                    Store (0x40, HFSP)
                }
                Else
                {
                    LED (0xFF, 0x80)
                    Store (0x80, HFSP)
                }
            }
        }
        Scope (\_SB.PCI0.LPC.EC)
        {
            Method (_Q63, 0, NotSerialized)
            {
                If (\_SB.PCI0.LPC.EC.HKEY.MHKK (0x00080000))
                {
                    \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x1014)
                }
                \UCMS (0x0B)
            }
        }
        Scope (\_SB.PCI0.LPC.EC)
        {
            Method (_Q70, 0, NotSerialized)
            {
                FNST ()
            }
            Method (_Q72, 0, NotSerialized)
            {
                FNST ()
            }
            Method (_Q73, 0, NotSerialized)
            {
                FNST ()
            }
            Method (FNST, 0, NotSerialized)
            {
                If (\H8DR)
                {
                    Store (HFNS, Local0)
                    Store (HFNE, Local1)
                }
                Else
                {
                    And (\RBEC (0x0E), 0x03, Local0)
                    And (\RBEC (0x00), 0x08, Local1)
                }
                If (Local1)
                {
                    If (LEqual (Local0, 0x00))
                    {
                        \UCMS (0x11)
                    }
                    If (LEqual (Local0, 0x01))
                    {
                        \UCMS (0x0F)
                    }
                    If (LEqual (Local0, 0x02))
                    {
                        \UCMS (0x10)
                    }
                    \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x6005)
                }
            }
        }
        Scope (\_SB.PCI0.LPC.EC.HKEY)
        {
            Method (GHSL, 1, NotSerialized)
            {
                Return (\FNSC (0x00, 0x00))
            }
            Method (SHSL, 1, NotSerialized)
            {
                Return (\FNSC (0x01, And (Arg0, 0x01)))
            }
        }
        Scope (\_SB.PCI0.LPC.EC.HKEY)
        {
            Name (WGFL, 0x00)
            Method (WSIF, 0, NotSerialized)
            {
                Return (0x00)
            }
            Method (WLSW, 0, NotSerialized)
            {
                Return (\_SB.PCI0.LPC.EC.GSTS)
            }
            Method (GWAN, 0, NotSerialized)
            {
                Store (0x00, Local0)
                If (And (WGFL, 0x01))
                {
                    Or (Local0, 0x01, Local0)
                }
                If (And (WGFL, 0x08))
                {
                    Return (Local0)
                }
                If (WPWS ())
                {
                    Or (Local0, 0x02, Local0)
                }
                Or (Local0, 0x04, Local0)
                Return (Local0)
            }
            Method (SWAN, 1, NotSerialized)
            {
                If (And (Arg0, 0x02))
                {
                    WPWC (0x01)
                }
                Else
                {
                    WPWC (0x00)
                }
            }
            Method (GBDC, 0, NotSerialized)
            {
                Store (0x00, Local0)
                If (And (WGFL, 0x10))
                {
                    Or (Local0, 0x01, Local0)
                }
                If (And (WGFL, 0x80))
                {
                    Return (Local0)
                }
                If (BPWS ())
                {
                    Or (Local0, 0x02, Local0)
                }
                Or (Local0, 0x04, Local0)
                Return (Local0)
            }
            Method (SBDC, 1, NotSerialized)
            {
                If (And (Arg0, 0x02))
                {
                    BPWC (0x01)
                }
                Else
                {
                    BPWC (0x00)
                }
            }
            Method (WPWS, 0, NotSerialized)
            {
                If (\H8DR)
                {
                    Store (\_SB.PCI0.LPC.EC.DCWW, Local0)
                }
                Else
                {
                    Store (ShiftRight (And (\RBEC (0x3A), 0x40), 0x06), Local0)
                }
                Return (Local0)
            }
            Method (WPWC, 1, NotSerialized)
            {
                If (LAnd (Arg0, LAnd (And (WGFL, 0x01), LNot (And (
                    WGFL, 0x08)))))
                {
                    If (\H8DR)
                    {
                        Store (One, \_SB.PCI0.LPC.EC.DCWW)
                    }
                    Else
                    {
                        \MBEC (0x3A, 0xFF, 0x40)
                    }
                    Or (WGFL, 0x02, WGFL)
                }
                Else
                {
                    If (\H8DR)
                    {
                        Store (Zero, \_SB.PCI0.LPC.EC.DCWW)
                    }
                    Else
                    {
                        \MBEC (0x3A, 0xBF, 0x00)
                    }
                    And (WGFL, Not (0x02), WGFL)
                }
            }
            Method (BPWS, 0, NotSerialized)
            {
                If (\H8DR)
                {
                    Store (\_SB.PCI0.LPC.EC.DCBD, Local0)
                }
                Else
                {
                    Store (ShiftRight (And (\RBEC (0x3A), 0x10), 0x04), Local0)
                }
                Return (Local0)
            }
            Method (BPWC, 1, NotSerialized)
            {
                If (LAnd (Arg0, LAnd (And (WGFL, 0x10), LNot (And (
                    WGFL, 0x80)))))
                {
                    If (\H8DR)
                    {
                        Store (One, \_SB.PCI0.LPC.EC.DCBD)
                    }
                    Else
                    {
                        \MBEC (0x3A, 0xFF, 0x10)
                    }
                    Or (WGFL, 0x20, WGFL)
                }
                Else
                {
                    If (\H8DR)
                    {
                        Store (Zero, \_SB.PCI0.LPC.EC.DCBD)
                    }
                    Else
                    {
                        \MBEC (0x3A, 0xEF, 0x00)
                    }
                    And (WGFL, Not (0x20), WGFL)
                }
            }
            Method (WGIN, 0, NotSerialized)
            {
                Store (0x00, WGFL)
                Store (\WGSV (0x01), WGFL)
                If (WPWS ())
                {
                    Or (WGFL, 0x02, WGFL)
                }
                If (BPWS ())
                {
                    Or (WGFL, 0x20, WGFL)
                }
            }
            Method (WGPS, 1, NotSerialized)
            {
                If (LGreaterEqual (Arg0, 0x04))
                {
                    \BLTH (0x05)
                }
            }
            Method (WGWK, 1, NotSerialized)
            {
                If (And (WGFL, 0x20))
                {
                    BPWC (0x01)
                }
                If (And (WGFL, 0x02))
                {
                    WPWC (0x01)
                }
            }
        }
        Scope (\_SB.PCI0.LPC.EC)
        {
            Method (_Q41, 0, NotSerialized)
            {
                \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x7000)
            }
        }
        Device (WMI1)
        {
            Name (_HID, EisaId ("PNP0C14"))
            Name (_UID, 0x01)
            Name (_WDG, Buffer (0xB4)
            {
                /* 0000 */   0x0E, 0x23, 0xF5, 0x51, 0x77, 0x96, 0xCD, 0x46,
                /* 0008 */   0xA1, 0xCF, 0xC0, 0xB2, 0x3E, 0xE3, 0x4D, 0xB7,
                /* 0010 */   0x41, 0x30, 0x50, 0x05, 0x64, 0x9A, 0x47, 0x98,
                /* 0018 */   0xF5, 0x33, 0x33, 0x4E, 0xA7, 0x07, 0x8E, 0x25,
                /* 0020 */   0x1E, 0xBB, 0xC3, 0xA1, 0x41, 0x31, 0x01, 0x06,
                /* 0028 */   0xEF, 0x54, 0x4B, 0x6A, 0xED, 0xA5, 0x33, 0x4D,
                /* 0030 */   0x94, 0x55, 0xB0, 0xD9, 0xB4, 0x8D, 0xF4, 0xB3,
                /* 0038 */   0x41, 0x32, 0x01, 0x06, 0xB6, 0xEB, 0xF1, 0x74,
                /* 0040 */   0x7A, 0x92, 0x7D, 0x4C, 0x95, 0xDF, 0x69, 0x8E,
                /* 0048 */   0x21, 0xE8, 0x0E, 0xB5, 0x41, 0x33, 0x01, 0x06,
                /* 0050 */   0xFF, 0x04, 0xEF, 0x7E, 0x28, 0x43, 0x7C, 0x44,
                /* 0058 */   0xB5, 0xBB, 0xD4, 0x49, 0x92, 0x5D, 0x53, 0x8D,
                /* 0060 */   0x41, 0x34, 0x01, 0x06, 0x9E, 0x15, 0xDB, 0x8A,
                /* 0068 */   0x32, 0x1E, 0x5C, 0x45, 0xBC, 0x93, 0x30, 0x8A,
                /* 0070 */   0x7E, 0xD9, 0x82, 0x46, 0x41, 0x35, 0x01, 0x01,
                /* 0078 */   0xFD, 0xD9, 0x51, 0x26, 0x1C, 0x91, 0x69, 0x4B,
                /* 0080 */   0xB9, 0x4E, 0xD0, 0xDE, 0xD5, 0x96, 0x3B, 0xD7,
                /* 0088 */   0x41, 0x36, 0x01, 0x06, 0x1A, 0x65, 0x64, 0x73,
                /* 0090 */   0x2F, 0x13, 0xE7, 0x4F, 0xAD, 0xAA, 0x40, 0xC6,
                /* 0098 */   0xC7, 0xEE, 0x2E, 0x3B, 0x41, 0x37, 0x01, 0x06,
                /* 00A0 */   0x21, 0x12, 0x90, 0x05, 0x66, 0xD5, 0xD1, 0x11,
                /* 00A8 */   0xB2, 0xF0, 0x00, 0xA0, 0xC9, 0x06, 0x29, 0x10,
                /* 00B0 */   0x42, 0x41, 0x01, 0x00
            })
            Name (RETN, Package (0x05)
            {
                "Success", 
                "Not Supported", 
                "Invalid Parameter", 
                "Access Denied", 
                "System Busy"
            })
            Name (ITEM, Package (0x6A)
            {
                Package (0x02)
                {
                    0x1C, 
                    "WakeOnLAN"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "FlashOverLAN"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "EthernetLANOptionROM"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "HarddriveDMA"
                }, 
                Package (0x02)
                {
                    0x04, 
                    "WirelessLANandWiMAXRadios"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "SerialPort"
                }, 
                Package (0x02)
                {
                    0x10, 
                    "SerialPortIO"
                }, 
                Package (0x02)
                {
                    0x06, 
                    "SerialPortIRQ"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "ParallelPort"
                }, 
                Package (0x02)
                {
                    0x09, 
                    "ParallelPortMode"
                }, 
                Package (0x02)
                {
                    0x11, 
                    "ParallelPortIO"
                }, 
                Package (0x02)
                {
                    0x07, 
                    "ParallelPortIRQ"
                }, 
                Package (0x02)
                {
                    0x08, 
                    "ParallelPortDMA"
                }, 
                Package (0x02)
                {
                    0x12, 
                    "PCIINTA"
                }, 
                Package (0x02)
                {
                    0x12, 
                    "PCIINTB"
                }, 
                Package (0x02)
                {
                    0x12, 
                    "PCIINTC"
                }, 
                Package (0x02)
                {
                    0x12, 
                    "PCIINTD"
                }, 
                Package (0x02)
                {
                    0x12, 
                    "PCIINTE"
                }, 
                Package (0x02)
                {
                    0x12, 
                    "PCIINTF"
                }, 
                Package (0x02)
                {
                    0x12, 
                    "PCIINTG"
                }, 
                Package (0x02)
                {
                    0x12, 
                    "PCIINTH"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "USBBIOSSupport"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "AlwaysOnUSB"
                }, 
                Package (0x02)
                {
                    0x02, 
                    "TrackPoint"
                }, 
                Package (0x02)
                {
                    0x02, 
                    "TouchPad"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "FnKeyLock"
                }, 
                Package (0x02)
                {
                    0x0A, 
                    "ThinkPadNumLock"
                }, 
                Package (0x02)
                {
                    0x17, 
                    "PowerOnNumLock"
                }, 
                Package (0x02)
                {
                    0x0B, 
                    "PrimaryVideo"
                }, 
                Package (0x02)
                {
                    0x0C, 
                    "BootDisplayDevice"
                }, 
                Package (0x02)
                {
                    0x05, 
                    "LCDBrightness"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "TimerWakeWithBattery"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "SpeedStep"
                }, 
                Package (0x02)
                {
                    0x13, 
                    "SpeedStepModeAC"
                }, 
                Package (0x02)
                {
                    0x13, 
                    "SpeedStepModeBattery"
                }, 
                Package (0x02)
                {
                    0x14, 
                    "AdaptiveThermalManagementAC"
                }, 
                Package (0x02)
                {
                    0x14, 
                    "AdaptiveThermalManagementBattery"
                }, 
                Package (0x02)
                {
                    0x0D, 
                    "CDROMSpeed"
                }, 
                Package (0x02)
                {
                    0x02, 
                    "CPUPowerManagement"
                }, 
                Package (0x02)
                {
                    0x02, 
                    "PCIPowerManagement"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "PowerControlBeep"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "LowBatteryAlarm"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "PasswordBeep"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "KeyboardBeep"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "ExtendedMemoryTest"
                }, 
                Package (0x02)
                {
                    0x0E, 
                    "SATAControllerMode"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "CoreMultiProcessing"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "VirtualizationTechnology"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "LegacyDevicesOnMiniDock"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "Passphrase"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "LockBIOSSetting"
                }, 
                Package (0x02)
                {
                    0x16, 
                    "MinimumPasswordLength"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "BIOSPasswordAtUnattendedBoot"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "PasswordResetService"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "FingerprintPredesktopAuthentication"
                }, 
                Package (0x02)
                {
                    0x0F, 
                    "FingerprintReaderPriority"
                }, 
                Package (0x02)
                {
                    0x05, 
                    "FingerprintSecurityMode"
                }, 
                Package (0x02)
                {
                    0x03, 
                    "SecurityChip"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "BIOSUpdateByEndUsers"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "DataExecutionPrevention"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "EthernetLANAccess"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "WirelessLANAccess"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "WirelessWANAccess"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "BluetoothAccess"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "WirelessUSBAccess"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "ModemAccess"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "USBPortAccess"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "IEEE1394Access"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "SerialPortAccess"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "ParallelPortAccess"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "CardBusSlotAccess"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "ExpressCardAccess"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "PCIExpressSlotAccess"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "UltrabayAccess"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "MemoryCardSlotAccess"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "SmartCardSlotAccess"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "IntegratedCameraAccess"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "MicrophoneAccess"
                }, 
                Package (0x02)
                {
                    0x15, 
                    "BootMode"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "StartupOptionKeys"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "BootDeviceListF12Option"
                }, 
                Package (0x02)
                {
                    0x64, 
                    "BootOrder"
                }, 
                Package (0x02)
                {
                    0x64, 
                    "NetworkBootOrder"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "WiMAXAccess"
                }, 
                Package (0x02)
                {
                    0x18, 
                    "GraphicsDevice"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "TXTFeature"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "VTdFeature"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "AMTControl"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "FingerprintPasswordAuthentication"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "FingerprintReaderAccess"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "OsDetectionForSwitchableGraphics"
                }, 
                Package (0x02)
                {
                    0x1D, 
                    "ComputraceModuleActivation"
                }, 
                Package (0x02)
                {
                    0x02, 
                    "PCIExpressPowerManagement"
                }, 
                Package (0x02)
                {
                    0x1D, 
                    "ATpModuleActivation"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "FullTheftProtectionModuleActivation"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "RemoteDisableModuleActivation"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "eSATAPortAccess"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "HardwarePasswordManager"
                }, 
                Package (0x02)
                {
                    0x1A, 
                    "AlwaysOnUSBMode"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "HyperThreadingTechnology"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "FnCtrlKeySwap"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "BIOSPasswordAtReboot"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "OnByAcAttach"
                }, 
                Package (0x02)
                {
                    0x64, 
                    "NetworkBoot"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "BootOrderLock"
                }, 
                Package (0x02)
                {
                    0x00, 
                    "ReserveMemoryForUEFIBootManager"
                }
            })
            Name (VSEL, Package (0x1E)
            {
                Package (0x02)
                {
                    "Disable", 
                    "Enable"
                }, 
                Package (0x02)
                {
                    "Enable", 
                    "Disable"
                }, 
                Package (0x02)
                {
                    "Disable", 
                    "Automatic"
                }, 
                Package (0x04)
                {
                    "Active", 
                    "Inactive", 
                    "Disable", 
                    ""
                }, 
                Package (0x02)
                {
                    "Off", 
                    "On"
                }, 
                Package (0x02)
                {
                    "Normal", 
                    "High"
                }, 
                Package (0x04)
                {
                    "3", 
                    "4", 
                    "5", 
                    "7"
                }, 
                Package (0x02)
                {
                    "5", 
                    "7"
                }, 
                Package (0x04)
                {
                    "0", 
                    "1", 
                    "3", 
                    ""
                }, 
                Package (0x03)
                {
                    "OutputOnly", 
                    "BiDirectional", 
                    "ECP"
                }, 
                Package (0x02)
                {
                    "Independent", 
                    "Synchronized"
                }, 
                Package (0x02)
                {
                    "PCIExpress", 
                    "Internal"
                }, 
                Package (0x10)
                {
                    "LCD", 
                    "VGA", 
                    "Digital", 
                    "Digital1onDock", 
                    "Digital2onDock", 
                    "", 
                    "", 
                    "", 
                    "", 
                    "", 
                    "", 
                    "", 
                    "", 
                    "", 
                    "", 
                    ""
                }, 
                Package (0x04)
                {
                    "High", 
                    "Normal", 
                    "Silent", 
                    ""
                }, 
                Package (0x04)
                {
                    "Compatibility", 
                    "AHCI", 
                    "RAID", 
                    ""
                }, 
                Package (0x02)
                {
                    "External", 
                    "InternalOnly"
                }, 
                Package (0x04)
                {
                    "3F8", 
                    "2F8", 
                    "3E8", 
                    "2E8"
                }, 
                Package (0x04)
                {
                    "378", 
                    "278", 
                    "3BC", 
                    ""
                }, 
                Package (0x10)
                {
                    "Disable", 
                    "AutoSelect", 
                    "", 
                    "3", 
                    "4", 
                    "5", 
                    "6", 
                    "7", 
                    "", 
                    "9", 
                    "10", 
                    "11", 
                    "", 
                    "", 
                    "", 
                    ""
                }, 
                Package (0x04)
                {
                    "MaximumPerformance", 
                    "BatteryOptimized", 
                    "MaximumBattery", 
                    "Automatic"
                }, 
                Package (0x02)
                {
                    "MaximizePerformance", 
                    "Balanced"
                }, 
                Package (0x02)
                {
                    "Quick", 
                    "Diagnostics"
                }, 
                Package (0x0A)
                {
                    "Disable", 
                    "4", 
                    "5", 
                    "6", 
                    "7", 
                    "8", 
                    "9", 
                    "10", 
                    "11", 
                    "12"
                }, 
                Package (0x04)
                {
                    "Auto", 
                    "On", 
                    "Off", 
                    ""
                }, 
                Package (0x04)
                {
                    "IntegratedGfx", 
                    "DiscreteGfx", 
                    "SwitchableGfx", 
                    ""
                }, 
                Package (0x04)
                {
                    "Automatic", 
                    "BlackBerry", 
                    "iPodiPhone", 
                    "OtherUSBDevices"
                }, 
                Package (0x04)
                {
                    "Disable", 
                    "Enable", 
                    "ACOnly", 
                    "ACandBattery"
                }, 
                Package (0x04)
                {
                    "Compatibility", 
                    "AHCI", 
                    "", 
                    "RAID"
                }, 
                Package (0x04)
                {
                    "Disable", 
                    "ACOnly", 
                    "ACandBattery", 
                    "Enable"
                }, 
                Package (0x04)
                {
                    "Disable", 
                    "Enable", 
                    "Disable", 
                    ""
                }
            })
            Name (VLST, Package (0x0F)
            {
                "HDD0", 
                "HDD1", 
                "HDD2", 
                "HDD3", 
                "HDD4", 
                "PCILAN", 
                "ATAPICD0", 
                "ATAPICD1", 
                "ATAPICD2", 
                "USBFDD", 
                "USBCD", 
                "USBHDD", 
                "OtherHDD", 
                "OtherCD", 
                "NODEV"
            })
            Name (PENC, Package (0x02)
            {
                "ascii", 
                "scancode"
            })
            Name (PKBD, Package (0x03)
            {
                "us", 
                "fr", 
                "gr"
            })
            Name (PTYP, Package (0x08)
            {
                "pap", 
                "pop", 
                "uhdp1", 
                "mhdp1", 
                "uhdp2", 
                "mhdp2", 
                "uhdp3", 
                "mhdp3"
            })
            Mutex (MWMI, 0x07)
            Name (PCFG, Buffer (0x18) {})
            Name (IBUF, Buffer (0x0100) {})
            Name (ILEN, 0x00)
            Name (PSTR, Buffer (0x81) {})
            Method (WQA0, 1, NotSerialized)
            {
                Acquire (MWMI, 0xFFFF)
                If (LNotEqual (\WMIS (0x00, Arg0), 0x00))
                {
                    Release (MWMI)
                    Return ("")
                }
                Store (DerefOf (Index (ITEM, \WITM)), Local0)
                Store (DerefOf (Index (Local0, 0x00)), Local1)
                Store (DerefOf (Index (Local0, 0x01)), Local2)
                If (LLess (Local1, 0x64))
                {
                    Concatenate (Local2, ",", Local6)
                    Store (DerefOf (Index (VSEL, Local1)), Local3)
                    Concatenate (Local6, DerefOf (Index (Local3, \WSEL)), Local7)
                }
                Else
                {
                    Store (SizeOf (VLST), Local3)
                    If (LLessEqual (\WLS0, Local3))
                    {
                        Concatenate (Local2, ",", Local7)
                        Concatenate (Local7, DerefOf (Index (VLST, \WLS0)), Local2)
                    }
                    If (LLessEqual (\WLS1, Local3))
                    {
                        Concatenate (Local2, ":", Local7)
                        Concatenate (Local7, DerefOf (Index (VLST, \WLS1)), Local2)
                    }
                    If (LLessEqual (\WLS2, Local3))
                    {
                        Concatenate (Local2, ":", Local7)
                        Concatenate (Local7, DerefOf (Index (VLST, \WLS2)), Local2)
                    }
                    If (LLessEqual (\WLS3, Local3))
                    {
                        Concatenate (Local2, ":", Local7)
                        Concatenate (Local7, DerefOf (Index (VLST, \WLS3)), Local2)
                    }
                    If (LLessEqual (\WLS4, Local3))
                    {
                        Concatenate (Local2, ":", Local7)
                        Concatenate (Local7, DerefOf (Index (VLST, \WLS4)), Local2)
                    }
                    If (LLessEqual (\WLS5, Local3))
                    {
                        Concatenate (Local2, ":", Local7)
                        Concatenate (Local7, DerefOf (Index (VLST, \WLS5)), Local2)
                    }
                    If (LLessEqual (\WLS6, Local3))
                    {
                        Concatenate (Local2, ":", Local7)
                        Concatenate (Local7, DerefOf (Index (VLST, \WLS6)), Local2)
                    }
                    If (LLessEqual (\WLS7, Local3))
                    {
                        Concatenate (Local2, ":", Local7)
                        Concatenate (Local7, DerefOf (Index (VLST, \WLS7)), Local2)
                    }
                    If (LLessEqual (\WLS8, Local3))
                    {
                        Concatenate (Local2, ":", Local7)
                        Concatenate (Local7, DerefOf (Index (VLST, \WLS8)), Local2)
                    }
                    If (LLessEqual (\WLS9, Local3))
                    {
                        Concatenate (Local2, ":", Local7)
                        Concatenate (Local7, DerefOf (Index (VLST, \WLS9)), Local2)
                    }
                    If (LLessEqual (\WLSA, Local3))
                    {
                        Concatenate (Local2, ":", Local7)
                        Concatenate (Local7, DerefOf (Index (VLST, \WLSA)), Local2)
                    }
                    If (LLessEqual (\WLSB, Local3))
                    {
                        Concatenate (Local2, ":", Local7)
                        Concatenate (Local7, DerefOf (Index (VLST, \WLSB)), Local2)
                    }
                    If (LLessEqual (\WLSC, Local3))
                    {
                        Concatenate (Local2, ":", Local7)
                        Concatenate (Local7, DerefOf (Index (VLST, \WLSC)), Local2)
                    }
                    If (LLessEqual (\WLSD, Local3))
                    {
                        Concatenate (Local2, ":", Local7)
                        Concatenate (Local7, DerefOf (Index (VLST, \WLSD)), Local2)
                    }
                    Store (Local2, Local7)
                }
                Release (MWMI)
                Return (Local7)
            }
            Method (WMA1, 3, NotSerialized)
            {
                Acquire (MWMI, 0xFFFF)
                If (LEqual (SizeOf (Arg2), 0x00))
                {
                    Store (0x02, Local0)
                }
                Else
                {
                    Store (CARG (Arg2), Local0)
                    If (LEqual (Local0, 0x00))
                    {
                        Store (WSET (), Local0)
                    }
                }
                Release (MWMI)
                Return (DerefOf (Index (RETN, Local0)))
            }
            Method (WMA2, 3, NotSerialized)
            {
                Acquire (MWMI, 0xFFFF)
                Store (CARG (Arg2), Local0)
                If (LEqual (Local0, 0x00))
                {
                    If (LNotEqual (ILEN, 0x00))
                    {
                        Store (CPAS (IBUF, 0x00), Local0)
                    }
                    If (LEqual (Local0, 0x00))
                    {
                        Store (\WMIS (0x02, 0x00), Local0)
                    }
                }
                Release (MWMI)
                Return (DerefOf (Index (RETN, Local0)))
            }
            Method (WMA3, 3, NotSerialized)
            {
                Acquire (MWMI, 0xFFFF)
                Store (CARG (Arg2), Local0)
                If (LEqual (Local0, 0x00))
                {
                    If (LNotEqual (ILEN, 0x00))
                    {
                        Store (CPAS (IBUF, 0x00), Local0)
                    }
                    If (LEqual (Local0, 0x00))
                    {
                        Store (\WMIS (0x03, 0x00), Local0)
                    }
                }
                Release (MWMI)
                Return (DerefOf (Index (RETN, Local0)))
            }
            Method (WMA4, 3, NotSerialized)
            {
                Acquire (MWMI, 0xFFFF)
                Store (CARG (Arg2), Local0)
                If (LEqual (Local0, 0x00))
                {
                    If (LNotEqual (ILEN, 0x00))
                    {
                        Store (CPAS (IBUF, 0x00), Local0)
                    }
                    If (LEqual (Local0, 0x00))
                    {
                        Store (\WMIS (0x04, 0x00), Local0)
                    }
                }
                Release (MWMI)
                Return (DerefOf (Index (RETN, Local0)))
            }
            Method (WQA5, 1, NotSerialized)
            {
                Acquire (MWMI, 0xFFFF)
                Store (\WMIS (0x05, 0x00), Local0)
                Store (\WSPM, Index (PCFG, 0x00))
                Store (\WSPS, Index (PCFG, 0x04))
                Store (\WSMN, Index (PCFG, 0x08))
                Store (\WSMX, Index (PCFG, 0x0C))
                Store (\WSEN, Index (PCFG, 0x10))
                Store (\WSKB, Index (PCFG, 0x14))
                Release (MWMI)
                Return (PCFG)
            }
            Method (WMA6, 3, NotSerialized)
            {
                Acquire (MWMI, 0xFFFF)
                If (LEqual (SizeOf (Arg2), 0x00))
                {
                    Store (0x02, Local0)
                }
                Else
                {
                    Store (CARG (Arg2), Local0)
                    If (LEqual (Local0, 0x00))
                    {
                        If (LNotEqual (ILEN, 0x00))
                        {
                            Store (SPAS (IBUF), Local0)
                        }
                        If (LEqual (Local0, 0x00))
                        {
                            Store (\WMIS (0x06, 0x00), Local0)
                        }
                    }
                }
                Release (MWMI)
                Return (DerefOf (Index (RETN, Local0)))
            }
            Method (WMA7, 3, NotSerialized)
            {
                If (LEqual (SizeOf (Arg2), 0x00))
                {
                    Return ("")
                }
                Store (CARG (Arg2), Local0)
                If (LEqual (Local0, 0x00))
                {
                    Store (GITM (IBUF), Local1)
                    If (LEqual (Local1, Ones))
                    {
                        Return ("")
                    }
                    Store (DerefOf (Index (ITEM, Local1)), Local0)
                    Store (DerefOf (Index (Local0, 0x00)), Local1)
                    If (LLess (Local1, 0x64))
                    {
                        Store (DerefOf (Index (VSEL, Local1)), Local3)
                        Store (DerefOf (Index (Local3, 0x00)), Local2)
                        Store (SizeOf (Local3), Local4)
                        Store (0x01, Local5)
                        While (LLess (Local5, Local4))
                        {
                            Store (DerefOf (Index (Local3, Local5)), Local6)
                            If (LNotEqual (SizeOf (Local6), 0x00))
                            {
                                Concatenate (Local2, ",", Local7)
                                Concatenate (Local7, Local6, Local2)
                            }
                            Increment (Local5)
                        }
                    }
                    Else
                    {
                        Store (DerefOf (Index (VLST, 0x00)), Local2)
                        Store (SizeOf (VLST), Local4)
                        Store (0x01, Local5)
                        While (LLess (Local5, Local4))
                        {
                            Store (DerefOf (Index (VLST, Local5)), Local6)
                            Concatenate (Local2, ",", Local7)
                            Concatenate (Local7, Local6, Local2)
                            Increment (Local5)
                        }
                    }
                }
                Return (Local2)
            }
            Method (CARG, 1, NotSerialized)
            {
                Store (SizeOf (Arg0), Local0)
                If (LEqual (Local0, 0x00))
                {
                    Store (0x00, IBUF)
                    Store (0x00, ILEN)
                    Return (0x00)
                }
                If (LNotEqual (ObjectType (Arg0), 0x02))
                {
                    Return (0x02)
                }
                If (LGreaterEqual (Local0, 0xFF))
                {
                    Return (0x02)
                }
                Store (Arg0, IBUF)
                Decrement (Local0)
                Store (DerefOf (Index (IBUF, Local0)), Local1)
                If (LOr (LEqual (Local1, 0x3B), LEqual (Local1, 0x2A)))
                {
                    Store (0x00, Index (IBUF, Local0))
                    Store (Local0, ILEN)
                }
                Else
                {
                    Store (SizeOf (Arg0), ILEN)
                }
                Return (0x00)
            }
            Method (SCMP, 3, NotSerialized)
            {
                Store (SizeOf (Arg0), Local0)
                If (LEqual (Local0, 0x00))
                {
                    Return (0x00)
                }
                Increment (Local0)
                Name (STR1, Buffer (Local0) {})
                Store (Arg0, STR1)
                Decrement (Local0)
                Store (0x00, Local1)
                Store (Arg2, Local2)
                While (LLess (Local1, Local0))
                {
                    Store (DerefOf (Index (STR1, Local1)), Local3)
                    Store (DerefOf (Index (Arg1, Local2)), Local4)
                    If (LNotEqual (Local3, Local4))
                    {
                        Return (0x00)
                    }
                    Increment (Local1)
                    Increment (Local2)
                }
                Store (DerefOf (Index (Arg1, Local2)), Local4)
                If (LEqual (Local4, 0x00))
                {
                    Return (0x01)
                }
                If (LOr (LEqual (Local4, 0x2C), LEqual (Local4, 0x3A)))
                {
                    Return (0x01)
                }
                Return (0x00)
            }
            Method (GITM, 1, NotSerialized)
            {
                Store (0x00, Local0)
                Store (SizeOf (ITEM), Local1)
                While (LLess (Local0, Local1))
                {
                    Store (DerefOf (Index (DerefOf (Index (ITEM, Local0)), 0x01)), 
                        Local3)
                    If (SCMP (Local3, Arg0, 0x00))
                    {
                        Return (Local0)
                    }
                    Increment (Local0)
                }
                Return (Ones)
            }
            Method (GSEL, 3, NotSerialized)
            {
                Store (0x00, Local0)
                Store (SizeOf (Arg0), Local1)
                While (LLess (Local0, Local1))
                {
                    Store (DerefOf (Index (Arg0, Local0)), Local2)
                    If (SCMP (Local2, Arg1, Arg2))
                    {
                        Return (Local0)
                    }
                    Increment (Local0)
                }
                Return (Ones)
            }
            Method (SLEN, 2, NotSerialized)
            {
                Store (DerefOf (Index (Arg0, Arg1)), Local0)
                Return (SizeOf (Local0))
            }
            Method (CLRP, 0, NotSerialized)
            {
                Store (0x00, \WPAS)
                Store (0x00, \WPNW)
            }
            Method (GPAS, 2, NotSerialized)
            {
                Store (Arg1, Local0)
                Store (0x00, Local1)
                While (LLessEqual (Local1, 0x80))
                {
                    Store (DerefOf (Index (Arg0, Local0)), Local2)
                    If (LOr (LEqual (Local2, 0x2C), LEqual (Local2, 0x00)))
                    {
                        Store (0x00, Index (PSTR, Local1))
                        Return (Local1)
                    }
                    Store (Local2, Index (PSTR, Local1))
                    Increment (Local0)
                    Increment (Local1)
                }
                Store (0x00, Index (PSTR, Local1))
                Return (Ones)
            }
            Method (CPAS, 2, NotSerialized)
            {
                CLRP ()
                Store (Arg1, Local0)
                Store (GPAS (Arg0, Local0), Local1)
                If (LEqual (Local1, Ones))
                {
                    Return (0x02)
                }
                If (LEqual (Local1, 0x00))
                {
                    Return (0x02)
                }
                Store (PSTR, \WPAS)
                Add (Local0, Local1, Local0)
                Increment (Local0)
                Store (GSEL (PENC, Arg0, Local0), Local6)
                If (LEqual (Local6, Ones))
                {
                    Return (0x02)
                }
                Store (Local6, \WENC)
                If (LEqual (Local6, 0x00))
                {
                    Add (Local0, SLEN (PENC, 0x00), Local0)
                    If (LNotEqual (DerefOf (Index (Arg0, Local0)), 0x2C))
                    {
                        Return (0x02)
                    }
                    Increment (Local0)
                    Store (GSEL (PKBD, Arg0, Local0), Local6)
                    If (LEqual (Local6, Ones))
                    {
                        Return (0x02)
                    }
                    Store (Local6, \WKBD)
                }
                Return (0x00)
            }
            Method (SPAS, 1, NotSerialized)
            {
                CLRP ()
                Store (GSEL (PTYP, Arg0, 0x00), Local6)
                If (LEqual (Local6, Ones))
                {
                    Return (0x02)
                }
                Store (Local6, \WPTY)
                Store (SLEN (PTYP, Local6), Local0)
                If (LNotEqual (DerefOf (Index (Arg0, Local0)), 0x2C))
                {
                    Return (0x02)
                }
                Increment (Local0)
                Store (GPAS (Arg0, Local0), Local1)
                If (LOr (LEqual (Local1, Ones), LEqual (Local1, 0x00)))
                {
                    Return (0x02)
                }
                Store (PSTR, \WPAS)
                Add (Local0, Local1, Local0)
                If (LNotEqual (DerefOf (Index (Arg0, Local0)), 0x2C))
                {
                    Return (0x02)
                }
                Increment (Local0)
                Store (GPAS (Arg0, Local0), Local1)
                If (LEqual (Local1, Ones))
                {
                    Return (0x02)
                }
                If (LEqual (Local1, 0x00))
                {
                    Store (0x00, PSTR)
                }
                Store (PSTR, \WPNW)
                Add (Local0, Local1, Local0)
                Increment (Local0)
                Store (GSEL (PENC, Arg0, Local0), Local6)
                If (LEqual (Local6, Ones))
                {
                    Return (0x02)
                }
                Store (Local6, \WENC)
                If (LEqual (Local6, 0x00))
                {
                    Add (Local0, SLEN (PENC, 0x00), Local0)
                    If (LNotEqual (DerefOf (Index (Arg0, Local0)), 0x2C))
                    {
                        Return (0x02)
                    }
                    Increment (Local0)
                    Store (GSEL (PKBD, Arg0, Local0), Local6)
                    If (LEqual (Local6, Ones))
                    {
                        Return (0x02)
                    }
                    Store (Local6, \WKBD)
                }
                Return (0x00)
            }
            Method (WSET, 0, NotSerialized)
            {
                Store (ILEN, Local0)
                Increment (Local0)
                Store (GITM (IBUF), Local1)
                If (LEqual (Local1, Ones))
                {
                    Return (0x02)
                }
                Store (Local1, \WITM)
                Store (DerefOf (Index (ITEM, Local1)), Local3)
                Store (DerefOf (Index (Local3, 0x01)), Local4)
                Store (SizeOf (Local4), Local2)
                Increment (Local2)
                Store (DerefOf (Index (Local3, 0x00)), Local4)
                If (LLess (Local4, 0x64))
                {
                    Store (DerefOf (Index (VSEL, Local4)), Local5)
                    Store (GSEL (Local5, IBUF, Local2), Local6)
                    If (LEqual (Local6, Ones))
                    {
                        Return (0x02)
                    }
                    Store (Local6, \WSEL)
                    Add (Local2, SLEN (Local5, Local6), Local2)
                    Store (DerefOf (Index (IBUF, Local2)), Local4)
                }
                Else
                {
                    Store (0x3F, \WLS0)
                    Store (0x3F, \WLS1)
                    Store (0x3F, \WLS2)
                    Store (0x3F, \WLS3)
                    Store (0x3F, \WLS4)
                    Store (0x3F, \WLS5)
                    Store (0x3F, \WLS6)
                    Store (0x3F, \WLS7)
                    Store (0x3F, \WLS8)
                    Store (0x3F, \WLS9)
                    Store (0x3F, \WLSA)
                    Store (0x3F, \WLSB)
                    Store (0x3F, \WLSC)
                    Store (0x3F, \WLSD)
                    Store (GSEL (VLST, IBUF, Local2), Local6)
                    If (LEqual (Local6, Ones))
                    {
                        Return (0x02)
                    }
                    Store (Local6, \WLS0)
                    Add (Local2, SLEN (VLST, Local6), Local2)
                    Store (DerefOf (Index (IBUF, Local2)), Local4)
                    If (LAnd (LLess (Local2, Local0), LEqual (Local4, 0x3A)))
                    {
                        Increment (Local2)
                        Store (GSEL (VLST, IBUF, Local2), Local6)
                        If (LEqual (Local6, Ones))
                        {
                            Return (0x02)
                        }
                        Store (Local6, \WLS1)
                        Add (Local2, SLEN (VLST, Local6), Local2)
                        Store (DerefOf (Index (IBUF, Local2)), Local4)
                    }
                    If (LAnd (LLess (Local2, Local0), LEqual (Local4, 0x3A)))
                    {
                        Increment (Local2)
                        Store (GSEL (VLST, IBUF, Local2), Local6)
                        If (LEqual (Local6, Ones))
                        {
                            Return (0x02)
                        }
                        Store (Local6, \WLS2)
                        Add (Local2, SLEN (VLST, Local6), Local2)
                        Store (DerefOf (Index (IBUF, Local2)), Local4)
                    }
                    If (LAnd (LLess (Local2, Local0), LEqual (Local4, 0x3A)))
                    {
                        Increment (Local2)
                        Store (GSEL (VLST, IBUF, Local2), Local6)
                        If (LEqual (Local6, Ones))
                        {
                            Return (0x02)
                        }
                        Store (Local6, \WLS3)
                        Add (Local2, SLEN (VLST, Local6), Local2)
                        Store (DerefOf (Index (IBUF, Local2)), Local4)
                    }
                    If (LAnd (LLess (Local2, Local0), LEqual (Local4, 0x3A)))
                    {
                        Increment (Local2)
                        Store (GSEL (VLST, IBUF, Local2), Local6)
                        If (LEqual (Local6, Ones))
                        {
                            Return (0x02)
                        }
                        Store (Local6, \WLS4)
                        Add (Local2, SLEN (VLST, Local6), Local2)
                        Store (DerefOf (Index (IBUF, Local2)), Local4)
                    }
                    If (LAnd (LLess (Local2, Local0), LEqual (Local4, 0x3A)))
                    {
                        Increment (Local2)
                        Store (GSEL (VLST, IBUF, Local2), Local6)
                        If (LEqual (Local6, Ones))
                        {
                            Return (0x02)
                        }
                        Store (Local6, \WLS5)
                        Add (Local2, SLEN (VLST, Local6), Local2)
                        Store (DerefOf (Index (IBUF, Local2)), Local4)
                    }
                    If (LAnd (LLess (Local2, Local0), LEqual (Local4, 0x3A)))
                    {
                        Increment (Local2)
                        Store (GSEL (VLST, IBUF, Local2), Local6)
                        If (LEqual (Local6, Ones))
                        {
                            Return (0x02)
                        }
                        Store (Local6, \WLS6)
                        Add (Local2, SLEN (VLST, Local6), Local2)
                        Store (DerefOf (Index (IBUF, Local2)), Local4)
                    }
                    If (LAnd (LLess (Local2, Local0), LEqual (Local4, 0x3A)))
                    {
                        Increment (Local2)
                        Store (GSEL (VLST, IBUF, Local2), Local6)
                        If (LEqual (Local6, Ones))
                        {
                            Return (0x02)
                        }
                        Store (Local6, \WLS7)
                        Add (Local2, SLEN (VLST, Local6), Local2)
                        Store (DerefOf (Index (IBUF, Local2)), Local4)
                    }
                    If (LAnd (LLess (Local2, Local0), LEqual (Local4, 0x3A)))
                    {
                        Increment (Local2)
                        Store (GSEL (VLST, IBUF, Local2), Local6)
                        If (LEqual (Local6, Ones))
                        {
                            Return (0x02)
                        }
                        Store (Local6, \WLS8)
                        Add (Local2, SLEN (VLST, Local6), Local2)
                        Store (DerefOf (Index (IBUF, Local2)), Local4)
                    }
                    If (LAnd (LLess (Local2, Local0), LEqual (Local4, 0x3A)))
                    {
                        Increment (Local2)
                        Store (GSEL (VLST, IBUF, Local2), Local6)
                        If (LEqual (Local6, Ones))
                        {
                            Return (0x02)
                        }
                        Store (Local6, \WLS9)
                        Add (Local2, SLEN (VLST, Local6), Local2)
                        Store (DerefOf (Index (IBUF, Local2)), Local4)
                    }
                    If (LAnd (LLess (Local2, Local0), LEqual (Local4, 0x3A)))
                    {
                        Increment (Local2)
                        Store (GSEL (VLST, IBUF, Local2), Local6)
                        If (LEqual (Local6, Ones))
                        {
                            Return (0x02)
                        }
                        Store (Local6, \WLSA)
                        Add (Local2, SLEN (VLST, Local6), Local2)
                        Store (DerefOf (Index (IBUF, Local2)), Local4)
                    }
                    If (LAnd (LLess (Local2, Local0), LEqual (Local4, 0x3A)))
                    {
                        Increment (Local2)
                        Store (GSEL (VLST, IBUF, Local2), Local6)
                        If (LEqual (Local6, Ones))
                        {
                            Return (0x02)
                        }
                        Store (Local6, \WLSB)
                        Add (Local2, SLEN (VLST, Local6), Local2)
                        Store (DerefOf (Index (IBUF, Local2)), Local4)
                    }
                    If (LAnd (LLess (Local2, Local0), LEqual (Local4, 0x3A)))
                    {
                        Increment (Local2)
                        Store (GSEL (VLST, IBUF, Local2), Local6)
                        If (LEqual (Local6, Ones))
                        {
                            Return (0x02)
                        }
                        Store (Local6, \WLSC)
                        Add (Local2, SLEN (VLST, Local6), Local2)
                        Store (DerefOf (Index (IBUF, Local2)), Local4)
                    }
                    If (LAnd (LLess (Local2, Local0), LEqual (Local4, 0x3A)))
                    {
                        Increment (Local2)
                        Store (GSEL (VLST, IBUF, Local2), Local6)
                        If (LEqual (Local6, Ones))
                        {
                            Return (0x02)
                        }
                        Store (Local6, \WLSD)
                        Add (Local2, SLEN (VLST, Local6), Local2)
                        Store (DerefOf (Index (IBUF, Local2)), Local4)
                    }
                }
                If (LAnd (LEqual (Local4, 0x2C), LLess (Local2, Local0)))
                {
                    Increment (Local2)
                    Store (CPAS (IBUF, Local2), Local0)
                    If (LNotEqual (Local0, 0x00))
                    {
                        Return (Local0)
                    }
                }
                Return (\WMIS (0x01, 0x00))
            }
            Name (WQBA, Buffer (0x089D)
            {
                /* 0000 */   0x46, 0x4F, 0x4D, 0x42, 0x01, 0x00, 0x00, 0x00,
                /* 0008 */   0x8D, 0x08, 0x00, 0x00, 0xF2, 0x36, 0x00, 0x00,
                /* 0010 */   0x44, 0x53, 0x00, 0x01, 0x1A, 0x7D, 0xDA, 0x54,
                /* 0018 */   0xA8, 0xC9, 0x9A, 0x00, 0x01, 0x06, 0x18, 0x42,
                /* 0020 */   0x10, 0x13, 0x10, 0x0A, 0x0D, 0x21, 0x02, 0x0B,
                /* 0028 */   0x83, 0x50, 0x4C, 0x18, 0x14, 0xA0, 0x45, 0x41,
                /* 0030 */   0xC8, 0x05, 0x14, 0x95, 0x02, 0x21, 0xC3, 0x02,
                /* 0038 */   0x14, 0x0B, 0x70, 0x2E, 0x40, 0xBA, 0x00, 0xE5,
                /* 0040 */   0x28, 0x72, 0x0C, 0x22, 0x02, 0xF7, 0xEF, 0x0F,
                /* 0048 */   0x31, 0x0E, 0x88, 0x14, 0x40, 0x48, 0x26, 0x84,
                /* 0050 */   0x44, 0x00, 0x53, 0x21, 0x70, 0x84, 0xA0, 0x5F,
                /* 0058 */   0x01, 0x08, 0x1D, 0xA2, 0xC9, 0xA0, 0x00, 0xA7,
                /* 0060 */   0x08, 0x82, 0xB4, 0x65, 0x01, 0xBA, 0x05, 0xF8,
                /* 0068 */   0x16, 0xA0, 0x1D, 0x42, 0x68, 0x15, 0x0A, 0x30,
                /* 0070 */   0x29, 0xC0, 0x27, 0x98, 0x2C, 0x0A, 0x90, 0x0D,
                /* 0078 */   0x26, 0xDB, 0x70, 0x64, 0x18, 0x4C, 0xE4, 0x18,
                /* 0080 */   0x50, 0x62, 0xC6, 0x80, 0xD2, 0x39, 0x05, 0xD9,
                /* 0088 */   0x04, 0x16, 0x74, 0xA1, 0x28, 0x9A, 0x46, 0x94,
                /* 0090 */   0x04, 0x07, 0x75, 0x0C, 0x11, 0x82, 0x97, 0x2B,
                /* 0098 */   0x40, 0xF2, 0x04, 0xA4, 0x79, 0x5E, 0xB2, 0x3E,
                /* 00A0 */   0x08, 0x0D, 0x81, 0x8D, 0x80, 0x47, 0x91, 0x00,
                /* 00A8 */   0xC2, 0x62, 0x2C, 0x53, 0xE2, 0x61, 0x50, 0x1E,
                /* 00B0 */   0x40, 0x24, 0x67, 0xA8, 0x28, 0x60, 0x7B, 0x9D,
                /* 00B8 */   0x88, 0x86, 0x75, 0x9C, 0x4C, 0x12, 0x1C, 0x6A,
                /* 00C0 */   0x94, 0x96, 0x28, 0xC0, 0xFC, 0xC8, 0x34, 0x91,
                /* 00C8 */   0x63, 0x6B, 0x7A, 0xC4, 0x82, 0x64, 0xD2, 0x86,
                /* 00D0 */   0x82, 0x1A, 0xBA, 0xA7, 0x75, 0x52, 0x9E, 0x68,
                /* 00D8 */   0xC4, 0x83, 0x32, 0x4C, 0x02, 0x8F, 0x82, 0xA1,
                /* 00E0 */   0x71, 0x82, 0xB2, 0x20, 0xE4, 0x60, 0xA0, 0x28,
                /* 00E8 */   0xC0, 0x93, 0xF0, 0x1C, 0x8B, 0x17, 0x20, 0x7C,
                /* 00F0 */   0xC6, 0xE4, 0x28, 0x10, 0x23, 0x81, 0x8F, 0x04,
                /* 00F8 */   0x1E, 0xCD, 0x31, 0x63, 0x81, 0xC2, 0x05, 0x3C,
                /* 0100 */   0x9F, 0x63, 0x88, 0x1C, 0xF7, 0x50, 0x63, 0x1C,
                /* 0108 */   0x45, 0xE4, 0x04, 0xEF, 0x00, 0x51, 0x8C, 0x56,
                /* 0110 */   0xD0, 0xBC, 0x85, 0x18, 0x2C, 0x9A, 0xC1, 0x7A,
                /* 0118 */   0x06, 0x27, 0x83, 0x4E, 0xF0, 0xFF, 0x3F, 0x02,
                /* 0120 */   0x2E, 0x03, 0x42, 0x1E, 0x05, 0x58, 0x1D, 0x94,
                /* 0128 */   0xA6, 0x61, 0x82, 0xEE, 0x05, 0xBC, 0x1A, 0x1A,
                /* 0130 */   0x13, 0xA0, 0x11, 0x43, 0xCA, 0x04, 0x38, 0xBB,
                /* 0138 */   0x2F, 0x68, 0x46, 0x6D, 0x09, 0x30, 0x27, 0x40,
                /* 0140 */   0x9B, 0x00, 0x6F, 0x08, 0x42, 0x39, 0xCF, 0x28,
                /* 0148 */   0xC7, 0x72, 0x8A, 0x51, 0x1E, 0x06, 0x62, 0xBE,
                /* 0150 */   0x0C, 0x04, 0x8D, 0x12, 0x23, 0xE6, 0xB9, 0xC4,
                /* 0158 */   0x35, 0x6C, 0x84, 0x18, 0x21, 0x4F, 0x21, 0x50,
                /* 0160 */   0xDC, 0xF6, 0x07, 0x41, 0x06, 0x8D, 0x1B, 0xBD,
                /* 0168 */   0x4F, 0x0B, 0x67, 0x75, 0x02, 0x47, 0xFF, 0xA4,
                /* 0170 */   0x60, 0x02, 0x4F, 0xF9, 0xC0, 0x9E, 0x0D, 0x4E,
                /* 0178 */   0xE0, 0x58, 0xA3, 0xC6, 0x38, 0x95, 0x04, 0x8E,
                /* 0180 */   0xFD, 0x80, 0x90, 0x06, 0x10, 0x45, 0x82, 0x47,
                /* 0188 */   0x9D, 0x16, 0x7C, 0x2E, 0xF0, 0xD0, 0x0E, 0xDA,
                /* 0190 */   0x73, 0x3C, 0x81, 0x20, 0x87, 0x70, 0x04, 0x4F,
                /* 0198 */   0x0C, 0x0F, 0x04, 0x1E, 0x03, 0xBB, 0x29, 0xF8,
                /* 01A0 */   0x08, 0xE0, 0x13, 0x02, 0xDE, 0x35, 0xA0, 0xAE,
                /* 01A8 */   0x06, 0x0F, 0x06, 0x6C, 0xD0, 0xE1, 0x30, 0xE3,
                /* 01B0 */   0xF5, 0xF0, 0xC3, 0x9D, 0xC0, 0x49, 0x3E, 0x60,
                /* 01B8 */   0xF0, 0xC3, 0x86, 0x07, 0x87, 0x9B, 0xE7, 0xC9,
                /* 01C0 */   0x1C, 0x59, 0xA9, 0x02, 0xCC, 0x1E, 0x0E, 0x74,
                /* 01C8 */   0x90, 0xF0, 0x69, 0x83, 0x9D, 0x01, 0x30, 0xF2,
                /* 01D0 */   0x07, 0x81, 0x1A, 0x99, 0xA1, 0x3D, 0xEE, 0x97,
                /* 01D8 */   0x0E, 0x43, 0x3E, 0x27, 0x1C, 0x16, 0x13, 0x7B,
                /* 01E0 */   0xEA, 0xA0, 0xE3, 0x01, 0xFF, 0x65, 0xE4, 0x39,
                /* 01E8 */   0xC3, 0xD3, 0xF7, 0x7C, 0x4D, 0x30, 0xEC, 0xC0,
                /* 01F0 */   0xD1, 0x03, 0x31, 0xF4, 0xC3, 0xC6, 0x61, 0x9C,
                /* 01F8 */   0x86, 0xEF, 0x1F, 0x3E, 0x2F, 0xC0, 0x38, 0x05,
                /* 0200 */   0x78, 0xE4, 0xFE, 0xFF, 0x1F, 0x52, 0x7C, 0x9A,
                /* 0208 */   0xE0, 0x47, 0x0B, 0x9F, 0x26, 0xD8, 0xF5, 0xE0,
                /* 0210 */   0x34, 0x9E, 0x03, 0x3C, 0x9C, 0xB3, 0xF2, 0x61,
                /* 0218 */   0x02, 0x6C, 0xF7, 0x13, 0x36, 0xA2, 0x77, 0x0B,
                /* 0220 */   0x8F, 0x06, 0x7B, 0x0A, 0x00, 0xDF, 0xF9, 0x05,
                /* 0228 */   0x9C, 0x77, 0x0D, 0x36, 0x58, 0x18, 0xE7, 0x17,
                /* 0230 */   0xE0, 0x71, 0x42, 0xF0, 0x10, 0xF8, 0x41, 0xC2,
                /* 0238 */   0x43, 0xE0, 0x03, 0x78, 0xFE, 0x38, 0x43, 0x2B,
                /* 0240 */   0x9D, 0x17, 0x72, 0x60, 0xF0, 0xCE, 0x39, 0x30,
                /* 0248 */   0x46, 0xC1, 0xF3, 0x3C, 0x36, 0x4C, 0xA0, 0x20,
                /* 0250 */   0xAF, 0x01, 0x85, 0x7A, 0x16, 0x50, 0x18, 0x9F,
                /* 0258 */   0x6A, 0x80, 0xD7, 0xFF, 0xFF, 0x54, 0x03, 0x5C,
                /* 0260 */   0x0E, 0x07, 0xB8, 0x93, 0x03, 0xDC, 0x7B, 0x01,
                /* 0268 */   0xBB, 0x38, 0x3C, 0xD7, 0xC0, 0x15, 0x7D, 0xAE,
                /* 0270 */   0x81, 0x7A, 0x6F, 0x29, 0x6E, 0x8C, 0xBA, 0xC6,
                /* 0278 */   0x04, 0x79, 0x14, 0x78, 0xA4, 0x89, 0xF2, 0x3C,
                /* 0280 */   0xF3, 0x2E, 0x13, 0xE1, 0xD9, 0xC6, 0xD7, 0x1A,
                /* 0288 */   0x4F, 0x21, 0x8E, 0xAF, 0x35, 0x46, 0x7C, 0x99,
                /* 0290 */   0x78, 0xB7, 0x31, 0xEE, 0xC1, 0x3D, 0xD6, 0x3C,
                /* 0298 */   0xE4, 0x18, 0xE4, 0x68, 0x22, 0xBC, 0x18, 0x04,
                /* 02A0 */   0x7C, 0xBC, 0xF1, 0xB1, 0x06, 0xBC, 0x62, 0x5E,
                /* 02A8 */   0x28, 0xB2, 0x70, 0xAC, 0x01, 0x34, 0xFE, 0xFF,
                /* 02B0 */   0x8F, 0x35, 0xC0, 0x0D, 0xEB, 0x01, 0x05, 0x7C,
                /* 02B8 */   0x47, 0x06, 0x76, 0x43, 0x81, 0x77, 0x42, 0x01,
                /* 02C0 */   0xFC, 0x24, 0x7E, 0x01, 0xE8, 0xC8, 0xE1, 0xB4,
                /* 02C8 */   0x20, 0xB2, 0xF1, 0x06, 0xF0, 0x29, 0x80, 0xAA,
                /* 02D0 */   0x01, 0xD2, 0x34, 0x61, 0x13, 0x4C, 0x4F, 0x2E,
                /* 02D8 */   0x78, 0x1F, 0x09, 0x9C, 0x9B, 0x44, 0xC9, 0x87,
                /* 02E0 */   0x45, 0xE1, 0x9C, 0xF5, 0x20, 0x42, 0x41, 0x0C,
                /* 02E8 */   0xE8, 0x20, 0xC7, 0x09, 0xF4, 0x19, 0xC5, 0x07,
                /* 02F0 */   0x91, 0x13, 0x7D, 0x22, 0xF4, 0xA0, 0x3C, 0x8C,
                /* 02F8 */   0x77, 0x14, 0x76, 0x02, 0xF1, 0x61, 0xC2, 0x63,
                /* 0300 */   0xF7, 0x31, 0x81, 0xFF, 0x63, 0x3C, 0x1B, 0xA3,
                /* 0308 */   0x5B, 0x0D, 0x86, 0xFE, 0xFF, 0xE7, 0x14, 0x0E,
                /* 0310 */   0xE6, 0x83, 0x08, 0x27, 0xA8, 0xEB, 0x26, 0x01,
                /* 0318 */   0x32, 0x7D, 0x47, 0x05, 0x50, 0x00, 0xF9, 0x5E,
                /* 0320 */   0xE0, 0x73, 0xC0, 0xB3, 0x01, 0x1B, 0xC3, 0xA3,
                /* 0328 */   0x80, 0xD1, 0x8C, 0xCE, 0xC3, 0x4F, 0x16, 0x15,
                /* 0330 */   0x77, 0xB2, 0x14, 0xC4, 0x93, 0x75, 0x94, 0xC9,
                /* 0338 */   0xA2, 0x67, 0xE2, 0x7B, 0x85, 0x67, 0xF4, 0xA6,
                /* 0340 */   0xE5, 0x39, 0x7A, 0xC2, 0xBE, 0x87, 0xC0, 0x3A,
                /* 0348 */   0x0C, 0x84, 0x7C, 0x30, 0xF0, 0x34, 0x0C, 0xE7,
                /* 0350 */   0xC9, 0x72, 0x38, 0x4F, 0x96, 0x8F, 0xC5, 0xD7,
                /* 0358 */   0x10, 0xF0, 0x09, 0x9C, 0x2D, 0xC8, 0xE1, 0x31,
                /* 0360 */   0xB1, 0x46, 0x45, 0xAF, 0x42, 0x1E, 0x1E, 0xBF,
                /* 0368 */   0x1C, 0x78, 0x3E, 0xCF, 0x08, 0x47, 0xF9, 0x24,
                /* 0370 */   0x81, 0xC3, 0x78, 0x26, 0xF1, 0x10, 0x7D, 0x2B,
                /* 0378 */   0x82, 0x35, 0x91, 0x93, 0xF6, 0x6D, 0xE1, 0x64,
                /* 0380 */   0x83, 0xBE, 0x9E, 0x61, 0x6E, 0x45, 0xB0, 0xFF,
                /* 0388 */   0xFF, 0xB7, 0x22, 0x38, 0x17, 0x34, 0x98, 0x99,
                /* 0390 */   0xEE, 0x55, 0xA8, 0x58, 0xF7, 0x2A, 0x40, 0xEC,
                /* 0398 */   0xB0, 0x5E, 0x7B, 0x7C, 0xB0, 0x82, 0x7B, 0xAF,
                /* 03A0 */   0x82, 0x7B, 0xA9, 0x7A, 0x56, 0x38, 0xC6, 0xF0,
                /* 03A8 */   0x0F, 0x53, 0x31, 0x4E, 0xE9, 0xB5, 0xD3, 0x40,
                /* 03B0 */   0x61, 0xA2, 0xC4, 0x7B, 0xAF, 0xF2, 0x18, 0xDF,
                /* 03B8 */   0xAB, 0xD8, 0x15, 0x2A, 0x4C, 0xAC, 0x97, 0x2B,
                /* 03C0 */   0xA3, 0xBE, 0x4E, 0x84, 0x0B, 0x14, 0x24, 0xD2,
                /* 03C8 */   0xAB, 0x55, 0x94, 0xC8, 0xF1, 0x0D, 0xF9, 0x5E,
                /* 03D0 */   0x05, 0x5E, 0x39, 0xF7, 0x2A, 0x90, 0xFD, 0xFF,
                /* 03D8 */   0xEF, 0x55, 0x80, 0x79, 0xB4, 0xF7, 0x2A, 0x30,
                /* 03E0 */   0x5E, 0x1B, 0xD8, 0x0D, 0x09, 0x16, 0xD0, 0x8B,
                /* 03E8 */   0x15, 0x60, 0x28, 0xF3, 0xC5, 0x8A, 0xE6, 0xBD,
                /* 03F0 */   0x58, 0x21, 0xFE, 0xFF, 0xE7, 0x12, 0xA6, 0xE7,
                /* 03F8 */   0x62, 0x45, 0xE6, 0x09, 0xFF, 0x66, 0x05, 0x70,
                /* 0400 */   0xFA, 0xFF, 0x7F, 0xB3, 0x02, 0x8C, 0xDD, 0x8B,
                /* 0408 */   0x30, 0x47, 0x2B, 0x78, 0x29, 0x6F, 0x56, 0x34,
                /* 0410 */   0xCE, 0x32, 0x14, 0x70, 0x41, 0x14, 0xC6, 0x37,
                /* 0418 */   0x2B, 0xC0, 0xD1, 0x75, 0x05, 0x37, 0x64, 0xB8,
                /* 0420 */   0x60, 0x51, 0x82, 0xF9, 0x10, 0xE2, 0xE9, 0x1C,
                /* 0428 */   0xF1, 0x43, 0xC2, 0x4B, 0xC0, 0x63, 0x8E, 0x07,
                /* 0430 */   0xFC, 0x40, 0xE0, 0xCB, 0x15, 0x98, 0xFE, 0xFF,
                /* 0438 */   0x04, 0x3E, 0xF9, 0x9E, 0xE5, 0xDB, 0xD4, 0x7B,
                /* 0440 */   0x2F, 0x3F, 0x60, 0xBD, 0x57, 0xF9, 0xF0, 0x1B,
                /* 0448 */   0xEB, 0x9D, 0xE1, 0xE5, 0xCA, 0x23, 0x89, 0x72,
                /* 0450 */   0x12, 0xA1, 0x7C, 0xB7, 0x7A, 0xAF, 0x32, 0x4A,
                /* 0458 */   0xC4, 0x17, 0x62, 0x9F, 0x82, 0x0D, 0x6D, 0x94,
                /* 0460 */   0xA7, 0x8A, 0xE8, 0xC6, 0x7B, 0xB9, 0x02, 0xAF,
                /* 0468 */   0xA4, 0xCB, 0x15, 0x40, 0x93, 0xE1, 0xBF, 0x5C,
                /* 0470 */   0x81, 0xEF, 0xE6, 0x80, 0xBD, 0x26, 0xC1, 0xF9,
                /* 0478 */   0xFF, 0x5F, 0x93, 0xF8, 0xF5, 0x0A, 0xF0, 0x93,
                /* 0480 */   0xFD, 0x7A, 0x45, 0x73, 0x5F, 0xAF, 0x50, 0xA2,
                /* 0488 */   0x20, 0xA4, 0x08, 0x48, 0x33, 0x05, 0xCF, 0xFD,
                /* 0490 */   0x0A, 0xE0, 0xC4, 0xFF, 0xFF, 0x7E, 0x05, 0x58,
                /* 0498 */   0x0E, 0x77, 0xBF, 0x02, 0x7A, 0xB7, 0x23, 0xF0,
                /* 04A0 */   0xA2, 0xBC, 0x1D, 0x61, 0xAF, 0x58, 0xF8, 0x8C,
                /* 04A8 */   0x57, 0x2C, 0x1A, 0x66, 0x25, 0x8A, 0xB7, 0x26,
                /* 04B0 */   0x0A, 0xE3, 0x2B, 0x16, 0x30, 0xF9, 0xFF, 0x5F,
                /* 04B8 */   0xB1, 0x80, 0xD9, 0x41, 0x14, 0x37, 0x6A, 0xB8,
                /* 04C0 */   0x17, 0x27, 0xDF, 0x7A, 0x3C, 0xDF, 0x88, 0xBE,
                /* 04C8 */   0xC3, 0x60, 0x4E, 0x58, 0x30, 0x6E, 0x58, 0xF0,
                /* 04D0 */   0x87, 0xF4, 0x30, 0xEC, 0x93, 0xC4, 0x3B, 0x96,
                /* 04D8 */   0x8F, 0x56, 0x06, 0x79, 0x03, 0x7E, 0xB2, 0x7A,
                /* 04E0 */   0xB0, 0x8A, 0x62, 0x84, 0x80, 0xC7, 0xF3, 0x2E,
                /* 04E8 */   0xEC, 0xA3, 0xD5, 0x9B, 0x96, 0x51, 0x62, 0xC7,
                /* 04F0 */   0xF2, 0x85, 0xEA, 0x59, 0xCB, 0xD7, 0x2C, 0x43,
                /* 04F8 */   0xC4, 0x7D, 0x20, 0xF6, 0x0D, 0x0B, 0xB0, 0xFD,
                /* 0500 */   0xFF, 0xBF, 0x61, 0x01, 0x8E, 0x2E, 0x0E, 0xFC,
                /* 0508 */   0xE0, 0x80, 0xBD, 0x61, 0x01, 0x3E, 0x67, 0x0A,
                /* 0510 */   0x9E, 0x1B, 0x16, 0xB0, 0xF9, 0xFF, 0xDF, 0xB0,
                /* 0518 */   0x00, 0xFE, 0xFF, 0xFF, 0x6F, 0x58, 0xC0, 0xE1,
                /* 0520 */   0x76, 0x85, 0xBD, 0x65, 0x61, 0x6F, 0x2F, 0x64,
                /* 0528 */   0x15, 0x34, 0xD4, 0x4A, 0x14, 0xFC, 0x7B, 0x65,
                /* 0530 */   0x18, 0x7A, 0xC3, 0x02, 0x1C, 0x8D, 0xDB, 0xA3,
                /* 0538 */   0x06, 0xC7, 0xD9, 0xE0, 0x49, 0x02, 0x73, 0xAE,
                /* 0540 */   0xC6, 0xCD, 0xE6, 0xE0, 0x02, 0x47, 0xE8, 0x1D,
                /* 0548 */   0x54, 0x73, 0x67, 0x97, 0x14, 0x18, 0xB7, 0x2C,
                /* 0550 */   0xB8, 0x97, 0xAA, 0x87, 0x86, 0x28, 0x07, 0xF1,
                /* 0558 */   0x2A, 0xFC, 0x60, 0xF5, 0x28, 0x75, 0x64, 0x8F,
                /* 0560 */   0x57, 0x4F, 0xC3, 0x3E, 0x66, 0xF9, 0x96, 0x65,
                /* 0568 */   0xA8, 0x08, 0x6F, 0x59, 0xEC, 0x0C, 0x11, 0x2F,
                /* 0570 */   0x56, 0x94, 0x10, 0xEF, 0x15, 0xA1, 0x7D, 0xE7,
                /* 0578 */   0x32, 0xF8, 0xA3, 0xB1, 0x51, 0x83, 0xBE, 0x1C,
                /* 0580 */   0xBF, 0x65, 0xC1, 0xFB, 0xFF, 0xDF, 0xB2, 0xE0,
                /* 0588 */   0x8B, 0xFC, 0xAB, 0xE8, 0x44, 0xE0, 0x5B, 0x16,
                /* 0590 */   0xC0, 0x8F, 0x60, 0x10, 0x72, 0x32, 0x70, 0xF4,
                /* 0598 */   0x79, 0x01, 0x3F, 0x80, 0x87, 0x11, 0x0F, 0x89,
                /* 05A0 */   0x05, 0x18, 0x38, 0xBD, 0x2F, 0xF9, 0x4C, 0xC1,
                /* 05A8 */   0x0F, 0x18, 0x3E, 0x53, 0xB0, 0xEB, 0x41, 0xF4,
                /* 05B0 */   0xC7, 0x00, 0x9F, 0x4B, 0x30, 0x83, 0x03, 0xFF,
                /* 05B8 */   0xB5, 0xE2, 0xD0, 0x3D, 0x8A, 0xD7, 0x07, 0x13,
                /* 05C0 */   0x78, 0x70, 0xFC, 0xFF, 0x3F, 0x38, 0xB8, 0x77,
                /* 05C8 */   0x86, 0x23, 0xF2, 0x1D, 0xC6, 0x83, 0x03, 0xDB,
                /* 05D0 */   0x41, 0x00, 0x38, 0x0C, 0x0E, 0x1F, 0x6A, 0x70,
                /* 05D8 */   0xE8, 0xF1, 0x18, 0x38, 0xA4, 0xCF, 0x63, 0xEC,
                /* 05E0 */   0xC2, 0xF0, 0x90, 0xE3, 0xA1, 0x81, 0x0D, 0xD0,
                /* 05E8 */   0x43, 0x03, 0x96, 0x93, 0x78, 0x0A, 0x39, 0x34,
                /* 05F0 */   0x30, 0x4B, 0x18, 0x1A, 0x50, 0x8A, 0x37, 0x34,
                /* 05F8 */   0xFA, 0xFF, 0x1F, 0x1A, 0x1F, 0x92, 0x0F, 0x0B,
                /* 0600 */   0x31, 0x9F, 0x72, 0x22, 0xBC, 0x2F, 0xF8, 0x04,
                /* 0608 */   0xC5, 0xD0, 0x5F, 0x53, 0x7C, 0xBB, 0xF0, 0x4D,
                /* 0610 */   0x10, 0x37, 0x3E, 0x70, 0x5D, 0x3A, 0x3D, 0x3E,
                /* 0618 */   0xE0, 0x73, 0xE4, 0xF2, 0xF8, 0x70, 0x47, 0x27,
                /* 0620 */   0x8F, 0x0F, 0x86, 0xCB, 0xAB, 0x0C, 0x39, 0x9A,
                /* 0628 */   0xF8, 0x68, 0xC5, 0x86, 0x07, 0xB6, 0x9B, 0x9E,
                /* 0630 */   0x87, 0x07, 0x7C, 0xAE, 0x9B, 0x60, 0xBC, 0x42,
                /* 0638 */   0xF2, 0x6B, 0x09, 0x8C, 0x13, 0x14, 0xFE, 0xBA,
                /* 0640 */   0x09, 0xDE, 0xFF, 0xFF, 0x75, 0x13, 0x78, 0x8E,
                /* 0648 */   0x82, 0x6B, 0xBD, 0x64, 0xD3, 0x20, 0xAF, 0x1C,
                /* 0650 */   0xC5, 0x7A, 0x11, 0x50, 0x18, 0x9F, 0xD9, 0x00,
                /* 0658 */   0x47, 0x63, 0x7D, 0x66, 0x03, 0xCB, 0xBD, 0x80,
                /* 0660 */   0xDD, 0xD8, 0xE0, 0x9E, 0xD6, 0x60, 0xDF, 0x1D,
                /* 0668 */   0x1E, 0xCE, 0x1E, 0xD3, 0x1E, 0xD5, 0x1E, 0xD0,
                /* 0670 */   0x7C, 0xC4, 0x8E, 0xF1, 0x96, 0x16, 0x24, 0x4E,
                /* 0678 */   0x84, 0xD7, 0x81, 0xA7, 0x35, 0x5F, 0x32, 0xE2,
                /* 0680 */   0x05, 0x7A, 0x5A, 0x33, 0x46, 0x9C, 0x97, 0x36,
                /* 0688 */   0x23, 0xBE, 0x52, 0x84, 0x78, 0x58, 0xF3, 0xC9,
                /* 0690 */   0xCD, 0x78, 0x0F, 0x13, 0xE1, 0xC2, 0xBC, 0xB0,
                /* 0698 */   0x3D, 0xAD, 0x81, 0xE3, 0xFF, 0x7F, 0x5A, 0x83,
                /* 06A0 */   0x23, 0xE7, 0x8A, 0x0D, 0xD0, 0xE4, 0xA2, 0x8F,
                /* 06A8 */   0x3B, 0xA4, 0x80, 0xE5, 0xDA, 0xC0, 0x6E, 0x29,
                /* 06B0 */   0xF0, 0x2E, 0xD8, 0xC0, 0xF9, 0xFF, 0x7F, 0x44,
                /* 06B8 */   0x01, 0x5F, 0x96, 0x0B, 0x36, 0xCD, 0x71, 0xC1,
                /* 06C0 */   0x46, 0x71, 0x58, 0x0D, 0x90, 0xE6, 0x09, 0xFF,
                /* 06C8 */   0x7A, 0x0D, 0xFE, 0x49, 0xF8, 0x7A, 0x0D, 0xD8,
                /* 06D0 */   0xBE, 0xC5, 0xE2, 0xAE, 0xD7, 0xC0, 0xEA, 0xFF,
                /* 06D8 */   0x7F, 0xBD, 0x06, 0x96, 0x82, 0x47, 0x4A, 0xEF,
                /* 06E0 */   0xD4, 0xE0, 0xBA, 0x69, 0xE3, 0x41, 0xDF, 0xB4,
                /* 06E8 */   0x61, 0x0A, 0xBE, 0x45, 0xD1, 0x28, 0xE4, 0x8A,
                /* 06F0 */   0xB6, 0x10, 0x0A, 0xE3, 0x5B, 0x14, 0xE0, 0x08,
                /* 06F8 */   0xFB, 0x2D, 0x0A, 0x2C, 0x17, 0xA7, 0xB7, 0x28,
                /* 0700 */   0xFC, 0x0C, 0x3C, 0x68, 0xDF, 0x75, 0x18, 0xA6,
                /* 0708 */   0xEF, 0xD0, 0xF0, 0x4F, 0x4D, 0xCF, 0x4D, 0x0F,
                /* 0710 */   0x4E, 0x0F, 0xCD, 0x3E, 0x48, 0xF9, 0x70, 0xF0,
                /* 0718 */   0xFC, 0xF4, 0xFF, 0x8F, 0xF1, 0x5E, 0xE7, 0x9B,
                /* 0720 */   0xD4, 0x6B, 0x94, 0x2F, 0x30, 0xC7, 0x10, 0x31,
                /* 0728 */   0xCA, 0xCB, 0xB4, 0x21, 0xE2, 0xF9, 0xD4, 0xE4,
                /* 0730 */   0xB3, 0x42, 0xDC, 0x10, 0x0F, 0xD1, 0x46, 0x88,
                /* 0738 */   0xFA, 0x3C, 0xED, 0x09, 0xBD, 0x46, 0x81, 0x57,
                /* 0740 */   0xD0, 0x35, 0x0A, 0xA0, 0xC9, 0xFD, 0x08, 0x77,
                /* 0748 */   0x8D, 0x02, 0xCB, 0xBD, 0x81, 0x9D, 0x87, 0xF8,
                /* 0750 */   0x95, 0xC8, 0xD7, 0x06, 0x18, 0xF7, 0x28, 0x38,
                /* 0758 */   0xFF, 0xFF, 0x7B, 0x14, 0x60, 0x23, 0xCC, 0x3D,
                /* 0760 */   0x8A, 0x06, 0xB9, 0x47, 0xA1, 0x4E, 0x26, 0xBE,
                /* 0768 */   0xD4, 0x79, 0xA2, 0xE0, 0x08, 0x7F, 0x91, 0x42,
                /* 0770 */   0xC5, 0x26, 0x51, 0xE8, 0xC3, 0x10, 0x2A, 0xE6,
                /* 0778 */   0x61, 0x84, 0x82, 0x18, 0xD0, 0x19, 0x4E, 0x14,
                /* 0780 */   0x68, 0x15, 0x27, 0x0A, 0x72, 0x8B, 0xF1, 0xA4,
                /* 0788 */   0x1E, 0xA3, 0x00, 0x5F, 0xCB, 0xF4, 0x50, 0x79,
                /* 0790 */   0xE4, 0xA1, 0x52, 0x10, 0x0F, 0xD5, 0x71, 0x86,
                /* 0798 */   0x8A, 0x9E, 0xA4, 0xE7, 0x8F, 0xF9, 0xFF, 0x1F,
                /* 07A0 */   0x1C, 0xB0, 0x07, 0x29, 0x80, 0x17, 0x0A, 0x6D,
                /* 07A8 */   0xFA, 0xD4, 0x68, 0xD4, 0xAA, 0x41, 0x99, 0x1A,
                /* 07B0 */   0x65, 0x1A, 0xD4, 0xEA, 0x53, 0xA9, 0x31, 0x63,
                /* 07B8 */   0xE7, 0x50, 0x4B, 0x3B, 0x4B, 0x50, 0x31, 0x8B,
                /* 07C0 */   0xD1, 0x68, 0x1C, 0x05, 0x84, 0xCA, 0xFE, 0x9B,
                /* 07C8 */   0x0B, 0xC4, 0x21, 0x9F, 0x3A, 0x02, 0x74, 0xB0,
                /* 07D0 */   0x17, 0x95, 0x80, 0x2C, 0x6B, 0x6D, 0x02, 0x71,
                /* 07D8 */   0x7C, 0x13, 0x10, 0x8D, 0x80, 0x48, 0xCB, 0x63,
                /* 07E0 */   0x42, 0x40, 0xCE, 0x0D, 0x22, 0x20, 0xAB, 0x58,
                /* 07E8 */   0x93, 0x80, 0xAC, 0xF9, 0x01, 0x23, 0x70, 0xEB,
                /* 07F0 */   0xD4, 0x01, 0xC4, 0x52, 0x82, 0xD0, 0x44, 0x0B,
                /* 07F8 */   0x17, 0xA8, 0xE3, 0x81, 0x68, 0x30, 0x84, 0x46,
                /* 0800 */   0x40, 0x0E, 0x46, 0x21, 0x20, 0xCB, 0xF8, 0x74,
                /* 0808 */   0x0B, 0xDC, 0x02, 0xAC, 0x00, 0x31, 0xF9, 0x20,
                /* 0810 */   0x54, 0xB0, 0x17, 0x50, 0xA6, 0x1E, 0x44, 0x40,
                /* 0818 */   0x56, 0xBA, 0x56, 0x01, 0x59, 0x37, 0x88, 0x80,
                /* 0820 */   0xFE, 0xFF, 0x2F, 0x83, 0x32, 0x03, 0xCE, 0x32,
                /* 0828 */   0xBA, 0x01, 0x62, 0x0A, 0x1F, 0x0A, 0x02, 0xB1,
                /* 0830 */   0x26, 0x3D, 0xA0, 0x4C, 0x20, 0x88, 0xAE, 0x1C,
                /* 0838 */   0xC4, 0x0F, 0x10, 0x93, 0x06, 0x22, 0x20, 0xC7,
                /* 0840 */   0x39, 0x98, 0x08, 0xDC, 0x71, 0x14, 0x01, 0x52,
                /* 0848 */   0x47, 0xC3, 0xA5, 0x20, 0x54, 0xFC, 0xF3, 0x44,
                /* 0850 */   0x20, 0x16, 0x64, 0x09, 0x8C, 0x82, 0xD0, 0x08,
                /* 0858 */   0x9A, 0x40, 0x98, 0x3C, 0x4F, 0x20, 0x2C, 0xD4,
                /* 0860 */   0x9F, 0x5C, 0xA7, 0x15, 0xA2, 0x6A, 0x88, 0xD4,
                /* 0868 */   0x15, 0x08, 0x0B, 0xFC, 0x30, 0xD0, 0x60, 0x9C,
                /* 0870 */   0x1E, 0x44, 0x40, 0x4E, 0xFA, 0xA7, 0x0A, 0x44,
                /* 0878 */   0x72, 0x83, 0x08, 0xC8, 0xF9, 0x9F, 0x22, 0x02,
                /* 0880 */   0x77, 0xEA, 0xD7, 0x84, 0x86, 0x4F, 0xBE, 0x58,
                /* 0888 */   0x41, 0x88, 0xB8, 0x87, 0x55, 0x50, 0xA2, 0x14,
                /* 0890 */   0x44, 0x40, 0x56, 0xF6, 0xB4, 0x12, 0x90, 0x75,
                /* 0898 */   0x82, 0x08, 0xC8, 0xFF, 0x7F
            })
        }
        Device (WMI2)
        {
            Name (_HID, EisaId ("PNP0C14"))
            Name (_UID, 0x02)
            Name (_WDG, Buffer (0x3C)
            {
                /* 0000 */   0xF1, 0x24, 0xB4, 0xFC, 0x5A, 0x07, 0x0E, 0x4E,
                /* 0008 */   0xBF, 0xC4, 0x62, 0xF3, 0xE7, 0x17, 0x71, 0xFA,
                /* 0010 */   0x41, 0x37, 0x01, 0x01, 0xE3, 0x5E, 0xBE, 0xE2,
                /* 0018 */   0xDA, 0x42, 0xDB, 0x49, 0x83, 0x78, 0x1F, 0x52,
                /* 0020 */   0x47, 0x38, 0x82, 0x02, 0x41, 0x38, 0x01, 0x02,
                /* 0028 */   0x21, 0x12, 0x90, 0x05, 0x66, 0xD5, 0xD1, 0x11,
                /* 0030 */   0xB2, 0xF0, 0x00, 0xA0, 0xC9, 0x06, 0x29, 0x10,
                /* 0038 */   0x42, 0x42, 0x01, 0x00
            })
            Name (PREL, Buffer (0x08)
            {
                 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
            })
            Method (WQA7, 1, NotSerialized)
            {
                Acquire (\_SB.WMI1.MWMI, 0xFFFF)
                \WMIS (0x07, 0x00)
                Store (\WLS0, Index (PREL, 0x00))
                Store (\WLS1, Index (PREL, 0x01))
                Store (\WLS2, Index (PREL, 0x02))
                Store (\WLS3, Index (PREL, 0x03))
                Store (\WLS4, Index (PREL, 0x04))
                Store (\WLS5, Index (PREL, 0x05))
                Store (\WLS6, Index (PREL, 0x06))
                Store (\WLS7, Index (PREL, 0x07))
                Release (\_SB.WMI1.MWMI)
                Return (PREL)
            }
            Method (WMA8, 3, NotSerialized)
            {
                CreateByteField (Arg2, 0x00, PRE0)
                CreateByteField (Arg2, 0x01, PRE1)
                CreateByteField (Arg2, 0x02, PRE2)
                CreateByteField (Arg2, 0x03, PRE3)
                CreateByteField (Arg2, 0x04, PRE4)
                CreateByteField (Arg2, 0x05, PRE5)
                CreateByteField (Arg2, 0x06, PRE6)
                CreateByteField (Arg2, 0x07, PRE7)
                Acquire (\_SB.WMI1.MWMI, 0xFFFF)
                Store (PRE0, \WLS0)
                Store (PRE1, \WLS1)
                Store (PRE2, \WLS2)
                Store (PRE3, \WLS3)
                Store (PRE4, \WLS4)
                Store (PRE5, \WLS5)
                Store (PRE6, \WLS6)
                Store (PRE7, \WLS7)
                \WMIS (0x08, 0x00)
                Release (\_SB.WMI1.MWMI)
            }
            Name (WQBB, Buffer (0x038A)
            {
                /* 0000 */   0x46, 0x4F, 0x4D, 0x42, 0x01, 0x00, 0x00, 0x00,
                /* 0008 */   0x7A, 0x03, 0x00, 0x00, 0xF0, 0x0B, 0x00, 0x00,
                /* 0010 */   0x44, 0x53, 0x00, 0x01, 0x1A, 0x7D, 0xDA, 0x54,
                /* 0018 */   0x18, 0xC5, 0x85, 0x00, 0x01, 0x06, 0x18, 0x42,
                /* 0020 */   0x10, 0x07, 0x10, 0x8A, 0x0D, 0x21, 0x02, 0x0B,
                /* 0028 */   0x83, 0x50, 0x50, 0x18, 0x14, 0xA0, 0x45, 0x41,
                /* 0030 */   0x88, 0x57, 0x04, 0x44, 0x0A, 0x84, 0x0C, 0x0B,
                /* 0038 */   0x50, 0x2C, 0xC0, 0xB9, 0x00, 0xE9, 0x02, 0x94,
                /* 0040 */   0xA3, 0xC8, 0x31, 0x88, 0x08, 0xDC, 0xBF, 0x3F,
                /* 0048 */   0xC4, 0x40, 0x20, 0x52, 0x00, 0x21, 0xA1, 0x10,
                /* 0050 */   0x12, 0x01, 0x4C, 0x85, 0xC0, 0x11, 0x82, 0x7E,
                /* 0058 */   0x05, 0x20, 0x74, 0x28, 0x40, 0xA6, 0x00, 0x83,
                /* 0060 */   0x02, 0x9C, 0x22, 0x88, 0x20, 0x4A, 0xCB, 0x02,
                /* 0068 */   0x74, 0x0B, 0xF0, 0x2D, 0x40, 0x3B, 0x84, 0xD0,
                /* 0070 */   0x22, 0x57, 0x2A, 0xC0, 0x22, 0x94, 0x7C, 0x02,
                /* 0078 */   0x4A, 0x22, 0x8A, 0x64, 0xE3, 0xC9, 0x36, 0x22,
                /* 0080 */   0x99, 0x87, 0x45, 0x0E, 0x02, 0x25, 0x66, 0x10,
                /* 0088 */   0x28, 0x9D, 0xB8, 0xB2, 0x89, 0xAB, 0x41, 0x1C,
                /* 0090 */   0x40, 0x94, 0xF3, 0x88, 0x92, 0xE0, 0xA8, 0x0E,
                /* 0098 */   0x22, 0x42, 0xEC, 0x72, 0x05, 0x48, 0x1E, 0x80,
                /* 00A0 */   0x34, 0x4F, 0x4C, 0xD6, 0xE7, 0xA0, 0x91, 0xB1,
                /* 00A8 */   0x11, 0xF0, 0x60, 0x12, 0x40, 0x58, 0x94, 0x75,
                /* 00B0 */   0x2A, 0x0A, 0x0C, 0xCA, 0x03, 0x88, 0xE4, 0x8C,
                /* 00B8 */   0x15, 0x05, 0x6C, 0xAF, 0x13, 0x91, 0xC9, 0x81,
                /* 00C0 */   0x52, 0x49, 0x70, 0xA8, 0x61, 0x7A, 0x6A, 0xCD,
                /* 00C8 */   0x4F, 0x4C, 0x13, 0x39, 0xB5, 0xA6, 0x87, 0x2C,
                /* 00D0 */   0x48, 0x26, 0x6D, 0x28, 0xA8, 0xB1, 0x7B, 0x5A,
                /* 00D8 */   0x27, 0xE5, 0x99, 0x46, 0x3C, 0x28, 0xC3, 0x24,
                /* 00E0 */   0xF0, 0x28, 0x18, 0x1A, 0x27, 0x28, 0xEB, 0x44,
                /* 00E8 */   0x40, 0x07, 0xCA, 0x01, 0x4F, 0xC2, 0x73, 0x2C,
                /* 00F0 */   0x5E, 0x80, 0xF0, 0x11, 0x93, 0xB3, 0x40, 0x8C,
                /* 00F8 */   0x04, 0x3E, 0x13, 0x78, 0xE4, 0xC7, 0x8C, 0x1D,
                /* 0100 */   0x51, 0xB8, 0x80, 0xE7, 0x73, 0x0C, 0x91, 0xE3,
                /* 0108 */   0x1E, 0x6A, 0x8C, 0xA3, 0x88, 0x7C, 0x38, 0x0C,
                /* 0110 */   0xED, 0x74, 0xE3, 0x1C, 0xD8, 0xE9, 0x14, 0x04,
                /* 0118 */   0x2E, 0x90, 0x60, 0x3D, 0xCF, 0x59, 0x20, 0xFF,
                /* 0120 */   0xFF, 0x18, 0x07, 0xC1, 0xF0, 0x8E, 0x01, 0x23,
                /* 0128 */   0x03, 0x42, 0x1E, 0x05, 0x58, 0x1D, 0x96, 0x26,
                /* 0130 */   0x91, 0xC0, 0xEE, 0x05, 0x68, 0xBC, 0x04, 0x48,
                /* 0138 */   0xE1, 0x20, 0xA5, 0x0C, 0x42, 0x30, 0x8D, 0x09,
                /* 0140 */   0xB0, 0x75, 0x68, 0x90, 0x37, 0x01, 0xD6, 0xAE,
                /* 0148 */   0x02, 0x42, 0x89, 0x74, 0x02, 0x71, 0x42, 0x44,
                /* 0150 */   0x89, 0x18, 0xD4, 0x40, 0x51, 0x6A, 0x43, 0x15,
                /* 0158 */   0x4C, 0x67, 0xC3, 0x13, 0x66, 0xDC, 0x10, 0x31,
                /* 0160 */   0x0C, 0x14, 0xB7, 0xFD, 0x41, 0x90, 0x61, 0xE3,
                /* 0168 */   0xC6, 0xEF, 0x41, 0x9D, 0xD6, 0xD9, 0x1D, 0xD3,
                /* 0170 */   0xAB, 0x82, 0x09, 0x3C, 0xE9, 0x37, 0x84, 0xA7,
                /* 0178 */   0x83, 0xA3, 0x38, 0xDA, 0xA8, 0x31, 0x9A, 0x23,
                /* 0180 */   0x65, 0xAB, 0x96, 0x06, 0x0E, 0x45, 0x82, 0x47,
                /* 0188 */   0x9D, 0x17, 0x7C, 0x32, 0xF0, 0xD0, 0x0E, 0xDB,
                /* 0190 */   0x83, 0x3D, 0x4B, 0x0F, 0xE1, 0x08, 0x9E, 0x19,
                /* 0198 */   0x1E, 0x09, 0x3C, 0x06, 0x76, 0x57, 0xF0, 0x21,
                /* 01A0 */   0xC0, 0x67, 0x04, 0xBC, 0x6B, 0x40, 0x5D, 0x0E,
                /* 01A8 */   0x1E, 0x0D, 0xD8, 0xA4, 0xC3, 0x61, 0xC6, 0xEB,
                /* 01B0 */   0xB9, 0x7B, 0xEA, 0x3E, 0x63, 0xF0, 0xF3, 0x86,
                /* 01B8 */   0x07, 0x87, 0x1B, 0xE9, 0xC9, 0x1C, 0x59, 0xA9,
                /* 01C0 */   0x02, 0xCC, 0x5E, 0x03, 0x74, 0x94, 0xF0, 0x81,
                /* 01C8 */   0x83, 0xDD, 0x05, 0x9E, 0x02, 0x4C, 0x60, 0xF9,
                /* 01D0 */   0x83, 0x40, 0x8D, 0xCC, 0xD0, 0x1E, 0xEF, 0x7B,
                /* 01D8 */   0x87, 0x21, 0x9F, 0x14, 0x0E, 0x8B, 0x89, 0x3D,
                /* 01E0 */   0x78, 0xD0, 0xF1, 0x80, 0xFF, 0x3E, 0xF2, 0xA4,
                /* 01E8 */   0xE1, 0xE9, 0x7B, 0xBE, 0x26, 0x18, 0x18, 0x42,
                /* 01F0 */   0x56, 0xC6, 0x83, 0x1A, 0x88, 0xA1, 0x5F, 0x15,
                /* 01F8 */   0x0E, 0xE3, 0x34, 0x7C, 0x02, 0xF1, 0x39, 0x20,
                /* 0200 */   0x48, 0x8C, 0x63, 0xF2, 0xE0, 0xFC, 0xFF, 0x27,
                /* 0208 */   0x70, 0xAC, 0x91, 0xD3, 0x73, 0x8A, 0xCF, 0x13,
                /* 0210 */   0xFC, 0x70, 0xE1, 0xF3, 0x04, 0x3B, 0x31, 0x9C,
                /* 0218 */   0xC6, 0x73, 0x80, 0x87, 0x73, 0x56, 0x3E, 0x4E,
                /* 0220 */   0x00, 0x0B, 0x88, 0xD7, 0x09, 0x3E, 0x50, 0xF8,
                /* 0228 */   0xB0, 0x87, 0xE6, 0x51, 0xBC, 0x44, 0xBC, 0x3D,
                /* 0230 */   0x98, 0x20, 0xDA, 0x43, 0x0C, 0x18, 0x67, 0x84,
                /* 0238 */   0x3B, 0x6F, 0xC0, 0x39, 0xC5, 0x00, 0x0F, 0xA8,
                /* 0240 */   0x43, 0xC0, 0x1C, 0x26, 0x3C, 0x04, 0x3E, 0x80,
                /* 0248 */   0x67, 0x90, 0x73, 0xF4, 0x31, 0xE7, 0xCC, 0x70,
                /* 0250 */   0xC7, 0x1D, 0xB0, 0x0D, 0x83, 0x47, 0xB6, 0x00,
                /* 0258 */   0xC2, 0xE2, 0x3C, 0x09, 0x14, 0xF0, 0x6D, 0x40,
                /* 0260 */   0x61, 0x7C, 0xB8, 0x01, 0xEF, 0xFF, 0xFF, 0x70,
                /* 0268 */   0x03, 0x5C, 0xCF, 0x07, 0xB8, 0xE3, 0x03, 0xDC,
                /* 0270 */   0x8B, 0x05, 0x3B, 0x3C, 0x3C, 0xDE, 0x00, 0x83,
                /* 0278 */   0x21, 0x3D, 0xD2, 0xBC, 0xD5, 0xC4, 0x78, 0xB5,
                /* 0280 */   0x09, 0x11, 0xE1, 0xA1, 0xE6, 0xDD, 0xC6, 0x48,
                /* 0288 */   0xF1, 0x1E, 0x6F, 0xD8, 0x35, 0xE6, 0x2C, 0x1E,
                /* 0290 */   0x40, 0xA2, 0x14, 0x87, 0xA6, 0x8B, 0x4D, 0x8C,
                /* 0298 */   0x28, 0x6F, 0x36, 0x86, 0x7D, 0xD3, 0x31, 0x50,
                /* 02A0 */   0xA8, 0x48, 0x11, 0xC2, 0xBC, 0x58, 0x84, 0x78,
                /* 02A8 */   0xBC, 0x01, 0xB3, 0xA4, 0x97, 0x8A, 0x3E, 0x07,
                /* 02B0 */   0x3E, 0xDE, 0x00, 0x5E, 0xFE, 0xFF, 0xC7, 0x1B,
                /* 02B8 */   0xC0, 0xC3, 0x30, 0x7C, 0x4C, 0x01, 0xDB, 0xCD,
                /* 02C0 */   0x81, 0xDD, 0x53, 0xE0, 0x9F, 0x53, 0x00, 0x47,
                /* 02C8 */   0x42, 0x1E, 0x01, 0x3A, 0x78, 0x58, 0x04, 0x88,
                /* 02D0 */   0x6C, 0x3C, 0x03, 0x7C, 0x26, 0xA2, 0x02, 0xA9,
                /* 02D8 */   0x34, 0x53, 0xB0, 0x8C, 0x53, 0xB0, 0x3A, 0x21,
                /* 02E0 */   0x72, 0x19, 0x14, 0x12, 0x01, 0xA1, 0x91, 0x19,
                /* 02E8 */   0xCE, 0x87, 0x44, 0x83, 0x19, 0xC4, 0xE7, 0x03,
                /* 02F0 */   0x9F, 0x29, 0x7C, 0x72, 0xE2, 0xFF, 0xFF, 0x93,
                /* 02F8 */   0x13, 0x78, 0x0E, 0x26, 0x0F, 0x15, 0xB0, 0x10,
                /* 0300 */   0x7D, 0x5A, 0xE0, 0x70, 0x3E, 0xB3, 0x70, 0x38,
                /* 0308 */   0x1F, 0x49, 0xF8, 0x01, 0x92, 0x1F, 0x95, 0xC0,
                /* 0310 */   0x25, 0xF0, 0xD0, 0x00, 0x0A, 0x20, 0xDF, 0x0F,
                /* 0318 */   0x7C, 0x0E, 0x78, 0x46, 0x60, 0x73, 0x78, 0x24,
                /* 0320 */   0xF0, 0x81, 0x80, 0xC1, 0xF3, 0x68, 0xA3, 0xA2,
                /* 0328 */   0x47, 0x1B, 0x0F, 0x8F, 0x1F, 0x19, 0x3C, 0x9F,
                /* 0330 */   0x07, 0x82, 0xA3, 0x7C, 0x24, 0xC0, 0x61, 0xBC,
                /* 0338 */   0x5F, 0x78, 0x88, 0x3E, 0xE5, 0xC0, 0x9A, 0xC8,
                /* 0340 */   0x51, 0x5B, 0xF4, 0x89, 0x40, 0xA0, 0xCF, 0x5C,
                /* 0348 */   0x98, 0x53, 0x0E, 0x70, 0x52, 0x68, 0xD3, 0xA7,
                /* 0350 */   0x46, 0xA3, 0x56, 0x0D, 0xCA, 0xD4, 0x28, 0xD3,
                /* 0358 */   0xA0, 0x56, 0x9F, 0x4A, 0x8D, 0x19, 0x33, 0x01,
                /* 0360 */   0x25, 0x71, 0x07, 0x05, 0x2A, 0x69, 0x59, 0x1A,
                /* 0368 */   0x97, 0x03, 0x81, 0xD0, 0x00, 0xA7, 0x4B, 0x81,
                /* 0370 */   0x38, 0xF4, 0x4B, 0x46, 0x80, 0x8E, 0xFB, 0x64,
                /* 0378 */   0x12, 0x90, 0xC5, 0xAE, 0x4A, 0x20, 0x96, 0xA9,
                /* 0380 */   0x02, 0xA2, 0x11, 0x10, 0x89, 0x06, 0x11, 0x90,
                /* 0388 */   0xFF, 0xFF
            })
        }
        Scope (\_SB.PCI0.LPC.EC.HKEY)
        {
            Mutex (BFWM, 0x07)
            Method (MHCF, 1, NotSerialized)
            {
                Store (\BFWC (Arg0), Local0)
                Return (Local0)
            }
            Method (MHPF, 1, NotSerialized)
            {
                Name (RETB, Buffer (0x25) {})
                Acquire (BFWM, 0xFFFF)
                If (LLessEqual (SizeOf (Arg0), 0x25))
                {
                    Store (Arg0, \BFWB)
                    If (\BFWP ())
                    {
                        \_SB.PCI0.LPC.EC.CHKS ()
                        \BFWL ()
                    }
                    Store (\BFWB, RETB)
                }
                Release (BFWM)
                Return (RETB)
            }
            Method (MHIF, 1, NotSerialized)
            {
                Name (RETB, Buffer (0x0A) {})
                Acquire (BFWM, 0xFFFF)
                \BFWG (Arg0)
                Store (\BFWB, RETB)
                Release (BFWM)
                Return (RETB)
            }
            Method (MHDM, 1, NotSerialized)
            {
                \BDMC (Arg0)
            }
        }
        Scope (\_SB.PCI0.LPC.EC.HKEY)
        {
            Method (PSSG, 1, NotSerialized)
            {
                Return (\PSIF (0x00, 0x00))
            }
            Method (PSSS, 1, NotSerialized)
            {
                Return (\PSIF (0x01, Arg0))
            }
            Method (PSBS, 1, NotSerialized)
            {
                Return (\PSIF (0x02, Arg0))
            }
            Method (BICG, 1, NotSerialized)
            {
                Return (\PSIF (0x03, Arg0))
            }
            Method (BICS, 1, NotSerialized)
            {
                Return (\PSIF (0x04, Arg0))
            }
            Method (BCTG, 1, NotSerialized)
            {
                Return (\PSIF (0x05, Arg0))
            }
            Method (BCCS, 1, NotSerialized)
            {
                Return (\PSIF (0x06, Arg0))
            }
            Method (BCSG, 1, NotSerialized)
            {
                Return (\PSIF (0x07, Arg0))
            }
            Method (BCSS, 1, NotSerialized)
            {
                Return (\PSIF (0x08, Arg0))
            }
            Method (BDSG, 1, NotSerialized)
            {
                Return (\PSIF (0x09, Arg0))
            }
            Method (BDSS, 1, NotSerialized)
            {
                Return (\PSIF (0x0A, Arg0))
            }
        }
        Scope (\_SB.PCI0.LPC.EC.HKEY)
        {
            Method (GILN, 0, NotSerialized)
            {
                Return (Or (0x02, \ILNF))
            }
            Method (SILN, 1, NotSerialized)
            {
                If (LEqual (0x01, Arg0))
                {
                    Store (0x01, \ILNF)
                    Store (0x00, BBLS)
                    Return (0x00)
                }
                Else
                {
                    If (LEqual (0x02, Arg0))
                    {
                        Store (0x00, \ILNF)
                        Store (0x01, BBLS)
                        Return (0x00)
                    }
                    Else
                    {
                        Return (0x01)
                    }
                }
            }
            Method (GLSI, 0, NotSerialized)
            {
                If (\H8DR)
                {
                    Return (Add (0x02, \_SB.PCI0.LPC.EC.HPLD))
                }
                Else
                {
                    If (And (\RBEC (0x46), 0x04))
                    {
                        Return (0x03)
                    }
                    Else
                    {
                        Return (0x02)
                    }
                }
            }
        }
        Scope (\_SB.PCI0.LPC.EC.HKEY)
        {
            Method (GDLN, 0, NotSerialized)
            {
                Return (Or (0x02, \PLUX))
            }
            Method (SDLN, 1, NotSerialized)
            {
                If (LEqual (0x01, Arg0))
                {
                    Store (0x01, \PLUX)
                    Return (0x00)
                }
                Else
                {
                    If (LEqual (0x02, Arg0))
                    {
                        Store (0x00, \PLUX)
                        Return (0x00)
                    }
                    Else
                    {
                        Return (0x01)
                    }
                }
            }
        }
        Name (\VHCC, 0x00)
        Scope (\_SB.PCI0.PEG.VID)
        {
            Method (ISOP, 0, NotSerialized)
            {
                Return (LAnd (VDSP, LAnd (VIGD, VDSC)))
            }
        }
        Scope (\_SB.PCI0)
        {
            Name (OTM, "OTMACPI 2009-Nov-12 18:18:51")
        }
        Scope (\_SB.PCI0.PEG.VID)
        {
            Method (GOBT, 1, NotSerialized)
            {
                Name (OPVK, Buffer (0xE6)
                {
                    /* 0000 */   0xE4, 0xB8, 0x4F, 0x51, 0x50, 0x72, 0x8A, 0xC2,
                    /* 0008 */   0x4B, 0x56, 0xE6, 0x00, 0x00, 0x00, 0x01, 0x00,
                    /* 0010 */   0x31, 0x34, 0x38, 0x35, 0x39, 0x37, 0x34, 0x35,
                    /* 0018 */   0x36, 0x39, 0x38, 0x35, 0x47, 0x65, 0x6E, 0x75,
                    /* 0020 */   0x69, 0x6E, 0x65, 0x20, 0x4E, 0x56, 0x49, 0x44,
                    /* 0028 */   0x49, 0x41, 0x20, 0x43, 0x65, 0x72, 0x74, 0x69,
                    /* 0030 */   0x66, 0x69, 0x65, 0x64, 0x20, 0x4F, 0x70, 0x74,
                    /* 0038 */   0x69, 0x6D, 0x75, 0x73, 0x20, 0x52, 0x65, 0x61,
                    /* 0040 */   0x64, 0x79, 0x20, 0x4D, 0x6F, 0x74, 0x68, 0x65,
                    /* 0048 */   0x72, 0x62, 0x6F, 0x61, 0x72, 0x64, 0x20, 0x66,
                    /* 0050 */   0x6F, 0x72, 0x20, 0x36, 0x38, 0x38, 0x33, 0x32,
                    /* 0058 */   0x35, 0x6E, 0x6F, 0x7A, 0x6F, 0x6D, 0x69, 0x32,
                    /* 0060 */   0x31, 0x44, 0x35, 0x20, 0x20, 0x20, 0x20, 0x20,
                    /* 0068 */   0x2D, 0x20, 0x40, 0x4A, 0x20, 0x24, 0x55, 0x27,
                    /* 0070 */   0x5C, 0x22, 0x54, 0x20, 0x29, 0x5F, 0x47, 0x42,
                    /* 0078 */   0x20, 0x50, 0x2F, 0x41, 0x4F, 0x5C, 0x37, 0x22,
                    /* 0080 */   0x3D, 0x46, 0x37, 0x39, 0x4B, 0x37, 0x2B, 0x5F,
                    /* 0088 */   0x3F, 0x4B, 0x48, 0x5C, 0x5F, 0x46, 0x58, 0x48,
                    /* 0090 */   0x5F, 0x44, 0x57, 0x32, 0x26, 0x4A, 0x46, 0x50,
                    /* 0098 */   0x52, 0x25, 0x24, 0x2F, 0x46, 0x24, 0x20, 0x2D,
                    /* 00A0 */   0x20, 0x43, 0x6F, 0x70, 0x79, 0x72, 0x69, 0x67,
                    /* 00A8 */   0x68, 0x74, 0x20, 0x32, 0x30, 0x31, 0x30, 0x20,
                    /* 00B0 */   0x4E, 0x56, 0x49, 0x44, 0x49, 0x41, 0x20, 0x43,
                    /* 00B8 */   0x6F, 0x72, 0x70, 0x6F, 0x72, 0x61, 0x74, 0x69,
                    /* 00C0 */   0x6F, 0x6E, 0x20, 0x41, 0x6C, 0x6C, 0x20, 0x52,
                    /* 00C8 */   0x69, 0x67, 0x68, 0x74, 0x73, 0x20, 0x52, 0x65,
                    /* 00D0 */   0x73, 0x65, 0x72, 0x76, 0x65, 0x64, 0x2D, 0x31,
                    /* 00D8 */   0x34, 0x38, 0x35, 0x39, 0x37, 0x34, 0x35, 0x36,
                    /* 00E0 */   0x39, 0x38, 0x35, 0x28, 0x52, 0x29
                })
                CreateWordField (Arg0, 0x02, USRG)
                If (LEqual (USRG, 0x564B))
                {
                    Return (OPVK)
                }
                Return (Zero)
            }
        }
        Scope (\_SB.PCI0.PEG.VID)
        {
            Name (OMPR, 0x02)
            Name (HDAS, 0x00)
            Method (NVOP, 4, NotSerialized)
            {
                Name (T_0, Zero)
                Store ("------- NV OPTIMUS DSM --------", Debug)
                If (LNotEqual (Arg1, 0x0100))
                {
                    Return (0x80000001)
                }
                Store (ToInteger (Arg2), T_0)
                If (LEqual (T_0, 0x00))
                {
                    Store (Buffer (0x04)
                        {
                             0x00, 0x00, 0x00, 0x00
                        }, Local0)
                    Divide (0x00, 0x08, Local2, Local1)
                    ShiftLeft (0x01, Local2, Local2)
                    Or (DerefOf (Index (Local0, Local1)), Local2, Index (Local0, Local1
                        ))
                    Divide (0x1A, 0x08, Local2, Local1)
                    ShiftLeft (0x01, Local2, Local2)
                    Or (DerefOf (Index (Local0, Local1)), Local2, Index (Local0, Local1
                        ))
                    Divide (0x1B, 0x08, Local2, Local1)
                    ShiftLeft (0x01, Local2, Local2)
                    Or (DerefOf (Index (Local0, Local1)), Local2, Index (Local0, Local1
                        ))
                    Divide (0x10, 0x08, Local2, Local1)
                    ShiftLeft (0x01, Local2, Local2)
                    Or (DerefOf (Index (Local0, Local1)), Local2, Index (Local0, Local1
                        ))
                    Return (Local0)
                }
                Else
                {
                    If (LEqual (T_0, 0x1A))
                    {
                        CreateField (Arg3, 0x18, 0x02, OPCE)
                        CreateField (Arg3, 0x00, 0x01, FLCH)
                        If (ToInteger (FLCH))
                        {
                            Store (OPCE, OMPR)
                        }
                        Store (Buffer (0x04)
                            {
                                 0x00, 0x00, 0x00, 0x00
                            }, Local0)
                        CreateField (Local0, 0x00, 0x01, OPEN)
                        CreateField (Local0, 0x03, 0x02, CGCS)
                        CreateField (Local0, 0x06, 0x01, SHPC)
                        CreateField (Local0, 0x18, 0x03, DGPC)
                        CreateField (Local0, 0x1B, 0x02, HDAC)
                        Store (One, OPEN)
                        Store (One, SHPC)
                        Store (One, DGPC)
                        If (\_SB.PCI0.PEG.VID._STA ())
                        {
                            Store (0x03, CGCS)
                        }
                        Store (0x02, HDAC)
                        Return (Local0)
                    }
                    Else
                    {
                        If (LEqual (T_0, 0x1B))
                        {
                            CreateField (Arg3, 0x00, 0x01, HDAU)
                            CreateField (Arg3, 0x01, 0x01, HDAR)
                            Store (Buffer (0x04)
                                {
                                     0x00, 0x00, 0x00, 0x00
                                }, Local0)
                            CreateField (Local0, 0x02, 0x02, RQGS)
                            CreateField (Local0, 0x04, 0x01, PWST)
                            Store (One, PWST)
                            If (LAnd (\_SB.PCI0.LPC.EC.DOCD, \_SB.PCI0.LPC.EC.AC._PSR ()))
                            {
                                Store (One, RQGS)
                            }
                            Else
                            {
                                Store (Zero, RQGS)
                            }
                            If (ToInteger (HDAR))
                            {
                                Store (ToInteger (HDAU), HDAS)
                            }
                            Return (Local0)
                        }
                        Else
                        {
                            If (LEqual (T_0, 0x10))
                            {
                                Return (\_SB.PCI0.PEG.VID.GOBT (Arg3))
                            }
                        }
                    }
                }
                Return (0x80000002)
            }
        }
        Scope (\)
        {
            Method (CMPB, 2, NotSerialized)
            {
                Store (SizeOf (Arg0), Local1)
                If (LNotEqual (Local1, SizeOf (Arg1)))
                {
                    Return (0x00)
                }
                Store (0x00, Local0)
                While (LLess (Local0, Local1))
                {
                    If (LNotEqual (DerefOf (Index (Arg0, Local0)), DerefOf (Index (
                        Arg1, Local0))))
                    {
                        Return (0x00)
                    }
                    Increment (Local0)
                }
                Return (0x01)
            }
        }
        Device (PNLF)
        {
            Name (_HID, EisaId ("APP0002"))
            Name (_CID, "backlight")
            Name (_UID, 0x0A)
            Name (_STA, 0x0B)
        }
    }
    Scope (\_SB.PCI0.EHC2.URTH.URMH.PRTC)
    {
        Name (_EJD, "\\_SB.GDCK")
    }
    Scope (\_SB.PCI0.EHC1.URTH.URMH.PRT5)
    {
        Name (_EJD, "\\_SB.PCI0.EXP4.SLOT")
    }
    Scope (\_SB.PCI0.EXP4.SLOT)
    {
        Name (_EJD, "\\_SB.PCI0.EHC1.URTH.URMH.PRT5")
    }
    Name (\_S0, Package (0x04)
    {
        0x00, 
        0x00, 
        0x00, 
        0x00
    })
    Name (\_S3, Package (0x04)
    {
        0x05, 
        0x05, 
        0x00, 
        0x00
    })
    Name (\_S4, Package (0x04)
    {
        0x06, 
        0x06, 
        0x00, 
        0x00
    })
    Name (\_S5, Package (0x04)
    {
        0x07, 
        0x07, 
        0x00, 
        0x00
    })
    Method (\_PTS, 1, NotSerialized)
    {
        Store (0x00, \_SB.PCI0.LPC.EC.OCPF)
        Store (0x01, Local0)
        If (LEqual (Arg0, \SPS))
        {
            Store (0x00, Local0)
        }
        If (LOr (LEqual (Arg0, 0x00), LGreaterEqual (Arg0, 0x06)))
        {
            Store (0x00, Local0)
        }
        If (Local0)
        {
            Store (Arg0, \SPS)
            \_SB.PCI0.LPC.EC.HKEY.MHKE (0x00)
            If (\_SB.PCI0.LPC.EC.KBLT)
            {
                \UCMS (0x0D)
            }
            If (LEqual (Arg0, 0x01))
            {
                Store (\_SB.PCI0.LPC.EC.HFNI, \FNID)
                Store (0x00, \_SB.PCI0.LPC.EC.HFNI)
                Store (0x00, \_SB.PCI0.LPC.EC.HFSP)
            }
            If (LEqual (Arg0, 0x03))
            {
                \VVPD (0x03)
                \TRAP ()
                Store (\_SB.PCI0.LPC.EC.AC._PSR (), \ACST)
            }
            If (LEqual (Arg0, 0x04))
            {
                \_SB.SLPB._PSW (0x00)
                \TRAP ()
                \_SB.PCI0.LPC.TPM.CMOR ()
                \AWON (0x04)
            }
            If (LEqual (Arg0, 0x05))
            {
                \TRAP ()
                \_SB.PCI0.LPC.TPM.CMOR ()
                \AWON (0x05)
            }
            \_SB.PCI0.LPC.EC.BPTS (Arg0)
            If (LGreaterEqual (Arg0, 0x04))
            {
                Store (0x00, \_SB.PCI0.LPC.EC.HWLB)
            }
            Else
            {
                Store (0x01, \_SB.PCI0.LPC.EC.HWLB)
            }
            If (LNotEqual (Arg0, 0x05))
            {
                Store (0x01, \_SB.PCI0.LPC.EC.HCMU)
                Store (\_SB.PCI0.EXP4.PDS, \_SB.PCI0.EXP4.PDSF)
                Store (\_SB.PCI0.EXP5.PDS, \_SB.PCI0.EXP5.PDSF)
            }
            \_SB.PCI0.LPC.EC.HKEY.WGPS (Arg0)
        }
    }
    Name (WAKI, Package (0x02)
    {
        0x00, 
        0x00
    })
    Method (\_WAK, 1, NotSerialized)
    {
        If (LOr (LEqual (Arg0, 0x00), LGreaterEqual (Arg0, 0x05)))
        {
            Return (WAKI)
        }
        Store (0x00, \SPS)
        Store (0x00, \_SB.PCI0.LPC.EC.HCMU)
        \_SB.PCI0.LPC.EC.EVNT (0x01)
        \_SB.PCI0.LPC.EC.HKEY.MHKE (0x01)
        \_SB.PCI0.LPC.EC.FNST ()
        \UCMS (0x0D)
        Store (0x00, \LIDB)
        If (LEqual (Arg0, 0x01))
        {
            Store (\_SB.PCI0.LPC.EC.HFNI, \FNID)
        }
        If (LEqual (Arg0, 0x03))
        {
            Store (\_SB.PCI0.LPC.EC.AC._PSR (), \PWRS)
            If (\OSC4)
            {
                \PNTF (0x81)
            }
            If (LNotEqual (\ACST, \_SB.PCI0.LPC.EC.AC._PSR ()))
            {
                \_SB.PCI0.LPC.EC.ATMC ()
            }
            If (\SCRM)
            {
                Store (0x07, \_SB.PCI0.LPC.EC.HFSP)
                If (\MTAU)
                {
                    Store (0x03E8, Local2)
                    While (LAnd (\_SB.PCI0.LPC.EC.PIBS, Local2))
                    {
                        Sleep (0x01)
                        Decrement (Local2)
                    }
                    If (Local2)
                    {
                        Store (0x01, \_SB.PCI0.LPC.EC.PLSL)
                        Store (\MTAU, \_SB.PCI0.LPC.EC.PLTU)
                        Store (\PL1L, \_SB.PCI0.LPC.EC.PLLS)
                        Store (\PL1M, \_SB.PCI0.LPC.EC.PLMS)
                    }
                }
            }
            If (\VIGD)
            {
                \_SB.PCI0.VID.GLIS (\_SB.LID._LID ())
                If (\WVIS)
                {
                    \VBTD ()
                }
            }
            Else
            {
                If (\WVIS)
                {
                    \_SB.PCI0.VID.GLIS (\_SB.LID._LID ())
                    \VBTD ()
                }
            }
            \VCMS (0x01, \_SB.LID._LID ())
            \AWON (0x00)
            If (\CMPR)
            {
                Notify (\_SB.SLPB, 0x02)
                Store (0x00, \CMPR)
            }
            Store (0x01, \_SB.PCI0.LPC.EC.OCPF)
        }
        If (LEqual (Arg0, 0x04))
        {
            \NVSS (0x00)
            Store (0x00, \_SB.PCI0.LPC.EC.HSPA)
            Store (\_SB.PCI0.LPC.EC.AC._PSR (), \PWRS)
            If (\OSC4)
            {
                \PNTF (0x81)
            }
            \_SB.PCI0.LPC.EC.ATMC ()
            Store (0x01, \_SB.PCI0.LPC.EC.OCPF)
            If (LNot (\NBCF))
            {
                If (\VIGD)
                {
                    \_SB.PCI0.LPC.EC.BRNS ()
                }
                Else
                {
                    \VBRC (\BRLV)
                }
            }
        }
        If (XOr (\_SB.PCI0.EXP4.PDS, \_SB.PCI0.EXP4.PDSF))
        {
            Store (\_SB.PCI0.EXP4.PDS, \_SB.PCI0.EXP4.PDSF)
            Notify (\_SB.PCI0.EXP4, 0x00)
        }
        If (XOr (\_SB.PCI0.EXP5.PDS, \_SB.PCI0.EXP5.PDSF))
        {
            Store (\_SB.PCI0.EXP5.PDS, \_SB.PCI0.EXP5.PDSF)
            Notify (\_SB.PCI0.EXP5, 0x00)
        }
        \_SB.PCI0.LPC.EC.BATW (Arg0)
        \_SB.PCI0.LPC.EC.BWAK (Arg0)
        \_SB.PCI0.LPC.EC.HKEY.WGWK (Arg0)
        Notify (\_TZ.THM0, 0x80)
        \VSLD (\_SB.LID._LID ())
        If (\VIGD)
        {
            \_SB.PCI0.VID.GLIS (\_SB.LID._LID ())
        }
        Else
        {
            If (\WVIS)
            {
                \_SB.PCI0.VID.GLIS (\_SB.LID._LID ())
            }
        }
        If (LLess (Arg0, 0x04))
        {
            If (And (\RRBF, 0x02))
            {
                ShiftLeft (Arg0, 0x08, Local0)
                Store (Or (0x2013, Local0), Local0)
                \_SB.PCI0.LPC.EC.HKEY.MHKQ (Local0)
            }
        }
        If (LEqual (Arg0, 0x04))
        {
            Store (0x00, Local0)
            Store (\CSUM (0x00), Local1)
            If (LNotEqual (Local1, \CHKC))
            {
                Store (0x01, Local0)
                Store (Local1, \CHKC)
            }
            Store (\CSUM (0x01), Local1)
            If (LNotEqual (Local1, \CHKE))
            {
                Store (0x01, Local0)
                Store (Local1, \CHKE)
            }
            If (Local0)
            {
                Notify (\_SB, 0x00)
            }
        }
        Store (Zero, \RRBF)
        Return (WAKI)
    }
    Scope (\_SI)
    {
        Method (_SST, 1, NotSerialized)
        {
            If (LEqual (Arg0, 0x00))
            {
                \_SB.PCI0.LPC.EC.LED (0x00, 0x00)
                \_SB.PCI0.LPC.EC.LED (0x07, 0x00)
            }
            If (LEqual (Arg0, 0x01))
            {
                If (LOr (\SPS, \WNTF))
                {
                    \_SB.PCI0.LPC.EC.BEEP (0x05)
                }
                \_SB.PCI0.LPC.EC.LED (0x00, 0x80)
                \_SB.PCI0.LPC.EC.LED (0x07, 0x00)
            }
            If (LEqual (Arg0, 0x02))
            {
                \_SB.PCI0.LPC.EC.LED (0x00, 0xC0)
                \_SB.PCI0.LPC.EC.LED (0x07, 0xC0)
            }
            If (LEqual (Arg0, 0x03))
            {
                If (LGreater (\SPS, 0x03))
                {
                    \_SB.PCI0.LPC.EC.BEEP (0x07)
                }
                Else
                {
                    If (LEqual (\SPS, 0x03))
                    {
                        \_SB.PCI0.LPC.EC.BEEP (0x03)
                    }
                    Else
                    {
                        \_SB.PCI0.LPC.EC.BEEP (0x04)
                    }
                }
                If (LEqual (\SPS, 0x03)) {}
                Else
                {
                    \_SB.PCI0.LPC.EC.LED (0x00, 0x80)
                }
                \_SB.PCI0.LPC.EC.LED (0x07, 0xC0)
                \_SB.PCI0.LPC.EC.LED (0x00, 0xC0)
            }
            If (LEqual (Arg0, 0x04))
            {
                \_SB.PCI0.LPC.EC.BEEP (0x03)
                \_SB.PCI0.LPC.EC.LED (0x07, 0xC0)
                \_SB.PCI0.LPC.EC.LED (0x00, 0xC0)
            }
        }
    }
    Scope (\_GPE)
    {
        Method (_L1D, 0, NotSerialized)
        {
            Store (\_SB.PCI0.LPC.EC.HWAK, Local0)
            Store (Local0, \RRBF)
            Sleep (0x0A)
            If (And (Local0, 0x02)) {}
            If (And (Local0, 0x04))
            {
                Notify (\_SB.LID, 0x02)
            }
            If (And (Local0, 0x08))
            {
                Notify (\_SB.SLPB, 0x02)
            }
            If (And (Local0, 0x10))
            {
                Notify (\_SB.SLPB, 0x02)
            }
            If (And (Local0, 0x40)) {}
            If (And (Local0, 0x80))
            {
                Notify (\_SB.SLPB, 0x02)
            }
        }
        Method (_L09, 0, NotSerialized)
        {
            If (\_SB.PCI0.EXP1.PS)
            {
                Store (0x01, \_SB.PCI0.EXP1.PS)
                Store (0x01, \_SB.PCI0.EXP1.PMCS)
                Notify (\_SB.PCI0.EXP1, 0x02)
            }
            If (\_SB.PCI0.EXP2.PS)
            {
                Store (0x01, \_SB.PCI0.EXP2.PS)
                Store (0x01, \_SB.PCI0.EXP2.PMCS)
                Notify (\_SB.PCI0.EXP2, 0x02)
            }
            If (\_SB.PCI0.EXP4.PS)
            {
                Store (0x01, \_SB.PCI0.EXP4.PS)
                Store (0x01, \_SB.PCI0.EXP4.PMCS)
                Notify (\_SB.PCI0.EXP4, 0x02)
            }
            If (\_SB.PCI0.EXP5.PS)
            {
                Store (0x01, \_SB.PCI0.EXP5.PS)
                Store (0x01, \_SB.PCI0.EXP5.PMCS)
                Notify (\_SB.PCI0.EXP5, 0x02)
            }
            If (\_SB.PCI0.EXP7.PS)
            {
                Store (0x01, \_SB.PCI0.EXP7.PS)
                Store (0x01, \_SB.PCI0.EXP7.PMCS)
                Notify (\_SB.PCI0.EXP7, 0x02)
            }
        }
        Method (_L01, 0, NotSerialized)
        {
            If (\_SB.PCI0.EXP4.HPCS)
            {
                Sleep (0x64)
                Store (0x01, \_SB.PCI0.EXP4.HPCS)
                If (\_SB.PCI0.EXP4.PDC)
                {
                    Store (0x01, \_SB.PCI0.EXP4.PDC)
                    Store (\_SB.PCI0.EXP4.PDS, \_SB.PCI0.EXP4.PDSF)
                    Notify (\_SB.PCI0.EXP4, 0x00)
                }
            }
            If (\_SB.PCI0.EXP5.HPCS)
            {
                Sleep (0x64)
                Store (0x01, \_SB.PCI0.EXP5.HPCS)
                If (\_SB.PCI0.EXP5.PDC)
                {
                    Store (0x01, \_SB.PCI0.EXP5.PDC)
                    Store (\_SB.PCI0.EXP5.PDS, \_SB.PCI0.EXP5.PDSF)
                    Notify (\_SB.PCI0.EXP5, 0x00)
                }
            }
        }
        Method (_L02, 0, NotSerialized)
        {
            Store (0x00, \_SB.PCI0.LPC.SWGE)
            If (LAnd (\CWUE, And (\SWGP, 0x02)))
            {
                And (\SWGP, Not (0x02), \SWGP)
                If (\OSC4)
                {
                    \PNTF (0x81)
                }
            }
        }
        Method (_L06, 0, NotSerialized)
        {
            If (\_SB.PCI0.VID.GSSE)
            {
                \_SB.PCI0.VID.GSCI ()
            }
            Else
            {
                Store (0x01, \_SB.PCI0.LPC.SCIS)
            }
        }
        Method (_L16, 0, NotSerialized)
        {
            If (\_SB.PCI0.PEG.VID.ISOP ())
            {
                If (LNot (\_SB.PCI0.LPC.XHPD))
                {
                    Notify (\_SB.PCI0.PEG.VID, 0x81)
                }
            }
            XOr (\_SB.PCI0.LPC.XHPD, 0x01, \_SB.PCI0.LPC.XHPD)
        }
    }
    Scope (\_SB.PCI0.LPC.EC.HKEY)
    {
        Method (MHQT, 1, NotSerialized)
        {
            If (LAnd (\WNTF, \TATC))
            {
                If (LEqual (Arg0, 0x00))
                {
                    Store (\TATC, Local0)
                    Return (Local0)
                }
                Else
                {
                    If (LEqual (Arg0, 0x01))
                    {
                        Store (\TDFA, Local0)
                        Add (Local0, ShiftLeft (\TDTA, 0x04), Local0)
                        Add (Local0, ShiftLeft (\TDFD, 0x08), Local0)
                        Add (Local0, ShiftLeft (\TDTD, 0x0C), Local0)
                        Add (Local0, ShiftLeft (\TNFT, 0x10), Local0)
                        Add (Local0, ShiftLeft (\TNTT, 0x14), Local0)
                        Return (Local0)
                    }
                    Else
                    {
                        If (LEqual (Arg0, 0x02))
                        {
                            Store (\TCFA, Local0)
                            Add (Local0, ShiftLeft (\TCTA, 0x04), Local0)
                            Add (Local0, ShiftLeft (\TCFD, 0x08), Local0)
                            Add (Local0, ShiftLeft (\TCTD, 0x0C), Local0)
                            Return (Local0)
                        }
                        Else
                        {
                            If (LEqual (Arg0, 0x03)) {}
                            Else
                            {
                                If (LEqual (Arg0, 0x04))
                                {
                                    Store (\TATW, Local0)
                                    Return (Local0)
                                }
                                Else
                                {
                                    Noop
                                }
                            }
                        }
                    }
                }
            }
            Return (0x00)
        }
        Method (MHAT, 1, NotSerialized)
        {
            If (LAnd (\WNTF, \TATC))
            {
                Store (And (Arg0, 0xFF), Local0)
                If (LNot (ATMV (Local0)))
                {
                    Return (0x00)
                }
                Store (And (ShiftRight (Arg0, 0x08), 0xFF), Local0)
                If (LNot (ATMV (Local0)))
                {
                    Return (0x00)
                }
                Store (And (Arg0, 0x0F), \TCFA)
                Store (And (ShiftRight (Arg0, 0x04), 0x0F), \TCTA)
                Store (And (ShiftRight (Arg0, 0x08), 0x0F), \TCFD)
                Store (And (ShiftRight (Arg0, 0x0C), 0x0F), \TCTD)
                ATMC ()
                If (And (\PPMF, 0x80))
                {
                    Store (\FTPS, Local1)
                    If (And (Arg0, 0x00010000))
                    {
                        Store (0x01, \FTPS)
                    }
                    Else
                    {
                        Store (0x00, \FTPS)
                    }
                    If (XOr (\FTPS, Local1))
                    {
                        If (\OSPX)
                        {
                            \PNTF (0x80)
                        }
                    }
                }
                Store (\SCRM, Local2)
                If (And (Arg0, 0x00040000))
                {
                    Store (0x01, \SCRM)
                    Store (0x07, \_SB.PCI0.LPC.EC.HFSP)
                }
                Else
                {
                    Store (0x00, \SCRM)
                    Store (0x80, \_SB.PCI0.LPC.EC.HFSP)
                }
                Store (\ETAU, Local3)
                If (And (Arg0, 0x00020000))
                {
                    Store (0x01, \ETAU)
                }
                Else
                {
                    Store (0x00, \ETAU)
                }
                If (\MTAU)
                {
                    If (LOr (XOr (\SCRM, Local2), XOr (\ETAU, Local3)))
                    {
                        Store (0x03E8, Local4)
                        While (\_SB.PCI0.LPC.EC.PIBS)
                        {
                            Sleep (0x01)
                            Decrement (Local4)
                            If (LNot (Local4))
                            {
                                Return (0x00)
                            }
                        }
                        Store (0x01, \_SB.PCI0.LPC.EC.PLSL)
                        If (And (Arg0, 0x00060000))
                        {
                            Store (\MTAU, \_SB.PCI0.LPC.EC.PLTU)
                        }
                        Else
                        {
                            Store (0x1C, \_SB.PCI0.LPC.EC.PLTU)
                        }
                        Store (\PL1L, \_SB.PCI0.LPC.EC.PLLS)
                        Store (\PL1M, \_SB.PCI0.LPC.EC.PLMS)
                    }
                }
                Return (0x01)
            }
            Return (0x00)
        }
        Method (MHGT, 1, NotSerialized)
        {
            If (LAnd (\WNTF, \TATC))
            {
                Store (0x01000000, Local0)
                If (And (\PPMF, 0x80))
                {
                    Or (Local0, 0x08000000, Local0)
                }
                If (\SCRM)
                {
                    Or (Local0, 0x10000000, Local0)
                }
                If (\ETAU)
                {
                    Or (Local0, 0x04000000, Local0)
                }
                If (\FTPS)
                {
                    Or (Local0, 0x02000000, Local0)
                }
                Add (Local0, ShiftLeft (\TSFT, 0x10), Local0)
                Add (Local0, ShiftLeft (\TSTT, 0x14), Local0)
                Store (And (Arg0, 0xFF), Local1)
                If (LNot (ATMV (Local1)))
                {
                    Or (Local0, 0xFFFF, Local0)
                    Return (Local0)
                }
                Store (And (Arg0, 0x0F), Local1)
                If (LEqual (Local1, 0x00))
                {
                    Add (Local0, \TIF0, Local0)
                }
                Else
                {
                    If (LEqual (Local1, 0x01))
                    {
                        Add (Local0, \TIF1, Local0)
                    }
                    Else
                    {
                        If (LEqual (Local1, 0x02))
                        {
                            Add (Local0, \TIF2, Local0)
                        }
                        Else
                        {
                            Add (Local0, 0xFF, Local0)
                        }
                    }
                }
                Store (And (ShiftRight (Arg0, 0x04), 0x0F), Local1)
                If (LEqual (Local1, 0x00))
                {
                    Add (Local0, ShiftLeft (\TIT0, 0x08), Local0)
                }
                Else
                {
                    If (LEqual (Local1, 0x01))
                    {
                        Add (Local0, ShiftLeft (\TIT1, 0x08), Local0)
                    }
                    Else
                    {
                        If (LEqual (Local1, 0x02))
                        {
                            Add (Local0, ShiftLeft (\TIT2, 0x08), Local0)
                        }
                        Else
                        {
                            Add (Local0, ShiftLeft (0xFF, 0x08), Local0)
                        }
                    }
                }
                Return (Local0)
            }
            Return (0x00)
        }
        Method (ATMV, 1, NotSerialized)
        {
            Store (And (Arg0, 0x0F), Local1)
            Store (\TNFT, Local0)
            If (LGreaterEqual (Local1, Local0))
            {
                Return (0x00)
            }
            Store (And (ShiftRight (Arg0, 0x04), 0x0F), Local2)
            Store (\TNTT, Local0)
            If (LGreaterEqual (Local2, Local0))
            {
                Return (0x00)
            }
            If (\TATL)
            {
                If (XOr (Local1, Local2))
                {
                    Return (0x00)
                }
            }
            Return (0x01)
        }
        Method (MHST, 0, NotSerialized)
        {
            Store (\_SB.PCI0.LPC.EC.HSPD, Local0)
            Return (Local0)
        }
        Method (MHTT, 0, NotSerialized)
        {
            Acquire (BFWM, 0xFFFF)
            \GCTP ()
            CreateByteField (\BFWB, 0x03, TMP3)
            CreateByteField (\BFWB, 0x0B, TMPB)
            If (\VIGD)
            {
                Store (0x00, Local0)
            }
            Else
            {
                Store (TMP3, Local0)
                ShiftLeft (Local0, 0x08, Local0)
            }
            Or (Local0, TMPB, Local0)
            ShiftLeft (Local0, 0x08, Local0)
            Or (Local0, \_SB.PCI0.LPC.EC.TMP0, Local0)
            Release (BFWM)
            Return (Local0)
        }
        Method (MHBT, 0, NotSerialized)
        {
            Name (ABUF, Buffer (0x10) {})
            ATMS (0x00)
            Store (\ATMB, ABUF)
            Return (ABUF)
        }
        Method (MHFT, 1, NotSerialized)
        {
            FSCT (Arg0)
        }
        Method (MHCT, 1, NotSerialized)
        {
            Store (0x00, Local0)
            If (\SPEN)
            {
                Store (\LWST, Local0)
                Increment (Local0)
                ShiftLeft (Local0, 0x08, Local0)
            }
            Store (0x08, Local1)
            ShiftLeft (Local1, 0x08, Local1)
            If (LEqual (Arg0, 0xFFFFFFFF))
            {
                Or (Local1, \TPCR, Local1)
                If (\SPEN)
                {
                    Or (Local0, \PPCR, Local0)
                    If (LNot (LAnd (\PPMF, 0x02000000)))
                    {
                        Or (Local1, 0x80, Local1)
                    }
                    If (LNot (LAnd (\PPMF, 0x08000000)))
                    {
                        Or (Local1, 0x40, Local1)
                    }
                }
                Else
                {
                    Or (Local1, 0xC0, Local1)
                }
            }
            Else
            {
                If (LAnd (\OSPX, \SPEN))
                {
                    And (Arg0, 0x00FF0000, Local2)
                    ShiftRight (Local2, 0x10, Local2)
                    Or (Local0, Local2, Local0)
                    If (XOr (Local2, \PPCR))
                    {
                        Store (Local2, \PPCA)
                        \PNTF (0x80)
                    }
                }
                If (\WVIS)
                {
                    And (Arg0, 0x1F, Local2)
                    Or (Local1, Local2, Local1)
                    If (XOr (Local2, \TPCR))
                    {
                        Store (Local2, \TPCA)
                        \PNTF (0x82)
                    }
                }
            }
            ShiftLeft (Local0, 0x10, Local0)
            Or (Local0, Local1, Local0)
            Return (Local0)
        }
    }
    Scope (\_SB.PCI0.LPC.EC)
    {
        Method (ATMC, 0, NotSerialized)
        {
            If (LAnd (\WNTF, \TATC))
            {
                If (HPAC)
                {
                    Store (\TCFA, Local0)
                    Store (\TCTA, Local1)
                    Store (Or (ShiftLeft (Local1, 0x04), Local0), Local2)
                    XOr (Local2, ATMX, Local3)
                    Store (Local2, ATMX)
                    If (LEqual (\TCTA, 0x00))
                    {
                        Store (\TCR0, \TCRT)
                        Store (\TPS0, \TPSV)
                    }
                    Else
                    {
                        If (LEqual (\TCTA, 0x01))
                        {
                            Store (\TCR1, \TCRT)
                            Store (\TPS1, \TPSV)
                        }
                        Else
                        {
                        }
                    }
                }
                Else
                {
                    Store (\TCFD, Local0)
                    Store (\TCTD, Local1)
                    Store (Or (ShiftLeft (Local1, 0x04), Local0), Local2)
                    XOr (Local2, ATMX, Local3)
                    Store (Local2, ATMX)
                    If (LEqual (\TCTD, 0x00))
                    {
                        Store (\TCR0, \TCRT)
                        Store (\TPS0, \TPSV)
                    }
                    Else
                    {
                        If (LEqual (\TCTD, 0x01))
                        {
                            Store (\TCR1, \TCRT)
                            Store (\TPS1, \TPSV)
                        }
                        Else
                        {
                        }
                    }
                }
                If (Local3)
                {
                    If (\_SB.PCI0.LPC.EC.HKEY.DHKC)
                    {
                        \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x6030)
                    }
                }
                Notify (\_TZ.THM0, 0x81)
            }
        }
    }
    Scope (\_TZ)
    {
        ThermalZone (THM0)
        {
            Method (_CRT, 0, NotSerialized)
            {
                Return (\TCRT)
            }
            Method (_TMP, 0, NotSerialized)
            {
                If (\H8DR)
                {
                    Store (\_SB.PCI0.LPC.EC.TMP0, Local0)
                    Store (\_SB.PCI0.LPC.EC.TSL2, Local1)
                    Store (\_SB.PCI0.LPC.EC.TSL3, Local2)
                }
                Else
                {
                    Store (\RBEC (0x78), Local0)
                    Store (And (\RBEC (0x8A), 0x7F), Local1)
                    Store (And (\RBEC (0x8B), 0x7F), Local2)
                }
                If (LEqual (Local0, 0x80))
                {
                    Store (0x30, Local0)
                }
                If (Local2)
                {
                    Return (C2K (0x80))
                }
                If (LNot (\_SB.PCI0.LPC.EC.HKEY.DHKC))
                {
                    If (Local1)
                    {
                        Return (C2K (0x80))
                    }
                }
                Return (C2K (Local0))
            }
        }
        Method (C2K, 1, NotSerialized)
        {
            Add (Multiply (Arg0, 0x0A), 0x0AAC, Local0)
            If (LLessEqual (Local0, 0x0AAC))
            {
                Store (0x0BB8, Local0)
            }
            If (LGreater (Local0, 0x0FAC))
            {
                Store (0x0BB8, Local0)
            }
            Return (Local0)
        }
    }
    Scope (\_SB.PCI0.LPC.EC)
    {
        Method (_Q40, 0, NotSerialized)
        {
            Notify (\_TZ.THM0, 0x80)
            If (\H8DR)
            {
                Store (\_SB.PCI0.LPC.EC.TSL2, Local1)
            }
            Else
            {
                Store (And (\RBEC (0x8A), 0x7F), Local1)
            }
            If (\_SB.PCI0.LPC.EC.HKEY.DHKC)
            {
                If (Local1)
                {
                    \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x6022)
                }
            }
            If (VIGD)
            {
                Noop
            }
            Else
            {
                \VTHR ()
            }
            If (And (\PPMF, 0x01))
            {
                If (\OSPX)
                {
                    \PNTF (0x80)
                }
                Else
                {
                    Store (And (\_SB.PCI0.LPC.EC.TSL0, 0x77), Local2)
                    If (Local2)
                    {
                        \STEP (0x09)
                    }
                    Else
                    {
                        \STEP (0x0A)
                    }
                }
            }
        }
    }
    Name (GPIC, 0x00)
    Method (_PIC, 1, NotSerialized)
    {
        Store (Arg0, \GPIC)
    }
    OperationRegion (SMI0, SystemIO, 0xB2, 0x01)
    Field (SMI0, ByteAcc, NoLock, Preserve)
    {
        APMC,   8
    }
    Field (MNVS, AnyAcc, NoLock, Preserve)
    {
        Offset (0xFC0), 
        CMD,    8, 
        ERR,    32, 
        PAR0,   32, 
        PAR1,   32, 
        PAR2,   32, 
        PAR3,   32
    }
    Mutex (MSMI, 0x07)
    Method (SMI, 5, NotSerialized)
    {
        Acquire (MSMI, 0xFFFF)
        Store (Arg0, CMD)
        Store (Arg1, PAR0)
        Store (Arg2, PAR1)
        Store (Arg3, PAR2)
        Store (Arg4, PAR3)
        Store (0xF5, APMC)
        While (LEqual (ERR, 0x01))
        {
            Sleep (0x64)
            Store (0xF5, APMC)
        }
        Store (PAR0, Local0)
        Release (MSMI)
        Return (Local0)
    }
    Method (RPCI, 1, NotSerialized)
    {
        Return (SMI (0x00, 0x00, Arg0, 0x00, 0x00))
    }
    Method (WPCI, 2, NotSerialized)
    {
        SMI (0x00, 0x01, Arg0, Arg1, 0x00)
    }
    Method (MPCI, 3, NotSerialized)
    {
        SMI (0x00, 0x02, Arg0, Arg1, Arg2)
    }
    Method (RBEC, 1, NotSerialized)
    {
        Return (SMI (0x00, 0x03, Arg0, 0x00, 0x00))
    }
    Method (WBEC, 2, NotSerialized)
    {
        SMI (0x00, 0x04, Arg0, Arg1, 0x00)
    }
    Method (MBEC, 3, NotSerialized)
    {
        SMI (0x00, 0x05, Arg0, Arg1, Arg2)
    }
    Method (RISA, 1, NotSerialized)
    {
        Return (SMI (0x00, 0x06, Arg0, 0x00, 0x00))
    }
    Method (WISA, 2, NotSerialized)
    {
        SMI (0x00, 0x07, Arg0, Arg1, 0x00)
    }
    Method (MISA, 3, NotSerialized)
    {
        SMI (0x00, 0x08, Arg0, Arg1, Arg2)
    }
    Method (VEXP, 0, NotSerialized)
    {
        SMI (0x01, 0x00, 0x00, 0x00, 0x00)
    }
    Method (VUPS, 1, NotSerialized)
    {
        SMI (0x01, 0x01, Arg0, 0x00, 0x00)
    }
    Method (VSDS, 2, NotSerialized)
    {
        SMI (0x01, 0x02, Arg0, Arg1, 0x00)
    }
    Method (VDDC, 0, NotSerialized)
    {
        SMI (0x01, 0x03, 0x00, 0x00, 0x00)
    }
    Method (VVPD, 1, NotSerialized)
    {
        SMI (0x01, 0x04, Arg0, 0x00, 0x00)
    }
    Method (VNRS, 1, NotSerialized)
    {
        SMI (0x01, 0x05, Arg0, 0x00, 0x00)
    }
    Method (GLPW, 0, NotSerialized)
    {
        Return (SMI (0x01, 0x06, 0x00, 0x00, 0x00))
    }
    Method (VSLD, 1, NotSerialized)
    {
        SMI (0x01, 0x07, Arg0, 0x00, 0x00)
    }
    Method (VEVT, 1, NotSerialized)
    {
        Return (SMI (0x01, 0x08, Arg0, 0x00, 0x00))
    }
    Method (VTHR, 0, NotSerialized)
    {
        Return (SMI (0x01, 0x09, 0x00, 0x00, 0x00))
    }
    Method (VBRC, 1, NotSerialized)
    {
        SMI (0x01, 0x0A, Arg0, 0x00, 0x00)
    }
    Method (VBRG, 0, NotSerialized)
    {
        Return (SMI (0x01, 0x0E, 0x00, 0x00, 0x00))
    }
    Method (VCMS, 2, NotSerialized)
    {
        Return (SMI (0x01, 0x0B, Arg0, Arg1, 0x00))
    }
    Method (VBTD, 0, NotSerialized)
    {
        Return (SMI (0x01, 0x0F, 0x00, 0x00, 0x00))
    }
    Method (VHYB, 2, NotSerialized)
    {
        Return (SMI (0x01, 0x10, Arg0, Arg1, 0x00))
    }
    Method (VDYN, 2, NotSerialized)
    {
        Return (SMI (0x01, 0x11, Arg0, Arg1, 0x00))
    }
    Method (UCMS, 1, NotSerialized)
    {
        Return (SMI (0x02, Arg0, 0x00, 0x00, 0x00))
    }
    Method (BHDP, 2, NotSerialized)
    {
        Return (SMI (0x03, 0x00, Arg0, Arg1, 0x00))
    }
    Method (STEP, 1, NotSerialized)
    {
        SMI (0x04, Arg0, 0x00, 0x00, 0x00)
    }
    Method (TRAP, 0, NotSerialized)
    {
        SMI (0x05, 0x00, 0x00, 0x00, 0x00)
    }
    Method (CBRI, 0, NotSerialized)
    {
        SMI (0x05, 0x01, 0x00, 0x00, 0x00)
    }
    Method (BCHK, 0, NotSerialized)
    {
        Return (SMI (0x05, 0x04, 0x00, 0x00, 0x00))
    }
    Method (BYRS, 0, NotSerialized)
    {
        SMI (0x05, 0x05, 0x00, 0x00, 0x00)
    }
    Method (LCHK, 1, NotSerialized)
    {
        Return (SMI (0x05, 0x06, Arg0, 0x00, 0x00))
    }
    Method (BLTH, 1, NotSerialized)
    {
        Return (SMI (0x06, Arg0, 0x00, 0x00, 0x00))
    }
    Method (PRSM, 2, NotSerialized)
    {
        Return (SMI (0x07, 0x00, Arg0, Arg1, 0x00))
    }
    Method (WGSV, 1, NotSerialized)
    {
        Return (SMI (0x09, Arg0, 0x00, 0x00, 0x00))
    }
    Method (ATMS, 1, NotSerialized)
    {
        Return (SMI (0x0A, 0x00, 0x00, 0x00, 0x00))
    }
    Method (FSCT, 1, NotSerialized)
    {
        Return (SMI (0x0A, 0x01, Arg0, 0x00, 0x00))
    }
    Method (SWTT, 1, NotSerialized)
    {
        If (SMI (0x0A, 0x02, Arg0, 0x00, 0x00))
        {
            If (\_SB.PCI0.LPC.EC.HKEY.DHKC)
            {
                \_SB.PCI0.LPC.EC.HKEY.MHKQ (0x6030)
            }
        }
    }
    Method (GCTP, 0, NotSerialized)
    {
        SMI (0x0A, 0x03, 0x00, 0x00, 0x00)
    }
    Method (TPHY, 1, NotSerialized)
    {
        SMI (0x0C, Arg0, 0x00, 0x00, 0x00)
    }
    Method (CSUM, 1, NotSerialized)
    {
        Return (SMI (0x0E, Arg0, 0x00, 0x00, 0x00))
    }
    Method (NVSS, 1, NotSerialized)
    {
        Return (SMI (0x0F, Arg0, 0x00, 0x00, 0x00))
    }
    Method (WMIS, 2, NotSerialized)
    {
        Return (SMI (0x10, Arg0, Arg1, 0x00, 0x00))
    }
    Method (AWON, 1, NotSerialized)
    {
        Return (SMI (0x12, Arg0, 0x00, 0x00, 0x00))
    }
    Method (PMON, 2, NotSerialized)
    {
        Store (SizeOf (Arg0), Local0)
        Name (TSTR, Buffer (Local0) {})
        Store (Arg0, TSTR)
        Store (TSTR, \DBGS)
        SMI (0x11, Arg1, 0x00, 0x00, 0x00)
    }
    Method (UAWS, 1, NotSerialized)
    {
        Return (SMI (0x13, Arg0, 0x00, 0x00, 0x00))
    }
    Method (BFWC, 1, NotSerialized)
    {
        Return (SMI (0x14, 0x00, Arg0, 0x00, 0x00))
    }
    Method (BFWP, 0, NotSerialized)
    {
        Return (SMI (0x14, 0x01, 0x00, 0x00, 0x00))
    }
    Method (BFWL, 0, NotSerialized)
    {
        SMI (0x14, 0x02, 0x00, 0x00, 0x00)
    }
    Method (BFWG, 1, NotSerialized)
    {
        SMI (0x14, 0x03, Arg0, 0x00, 0x00)
    }
    Method (BDMC, 1, NotSerialized)
    {
        SMI (0x14, 0x04, Arg0, 0x00, 0x00)
    }
    Method (PSIF, 2, NotSerialized)
    {
        Return (SMI (0x14, 0x05, Arg0, Arg1, 0x00))
    }
    Method (FNSC, 2, NotSerialized)
    {
        Return (SMI (0x14, 0x06, Arg0, Arg1, 0x00))
    }
    Method (AUDC, 2, NotSerialized)
    {
        Return (SMI (0x14, 0x07, Arg0, Arg1, 0x00))
    }
    Method (SYBC, 2, NotSerialized)
    {
        Return (SMI (0x14, 0x08, Arg0, Arg1, 0x00))
    }
    Method (DPIO, 2, NotSerialized)
    {
        If (LNot (Arg0))
        {
            Return (0x00)
        }
        If (LGreater (Arg0, 0xF0))
        {
            Return (0x00)
        }
        If (LGreater (Arg0, 0xB4))
        {
            If (Arg1)
            {
                Return (0x02)
            }
            Else
            {
                Return (0x01)
            }
        }
        If (LGreater (Arg0, 0x78))
        {
            Return (0x03)
        }
        Return (0x04)
    }
    Method (DUDM, 2, NotSerialized)
    {
        If (LNot (Arg1))
        {
            Return (0xFF)
        }
        If (LGreater (Arg0, 0x5A))
        {
            Return (0x00)
        }
        If (LGreater (Arg0, 0x3C))
        {
            Return (0x01)
        }
        If (LGreater (Arg0, 0x2D))
        {
            Return (0x02)
        }
        If (LGreater (Arg0, 0x1E))
        {
            Return (0x03)
        }
        If (LGreater (Arg0, 0x14))
        {
            Return (0x04)
        }
        Return (0x05)
    }
    Method (DMDM, 2, NotSerialized)
    {
        If (Arg1)
        {
            Return (0x00)
        }
        If (LNot (Arg0))
        {
            Return (0x00)
        }
        If (LGreater (Arg0, 0x96))
        {
            Return (0x01)
        }
        If (LGreater (Arg0, 0x78))
        {
            Return (0x02)
        }
        Return (0x03)
    }
    Method (UUDM, 2, NotSerialized)
    {
        If (LNot (And (Arg0, 0x04)))
        {
            Return (0x00)
        }
        If (And (Arg1, 0x20))
        {
            Return (0x14)
        }
        If (And (Arg1, 0x10))
        {
            Return (0x1E)
        }
        If (And (Arg1, 0x08))
        {
            Return (0x2D)
        }
        If (And (Arg1, 0x04))
        {
            Return (0x3C)
        }
        If (And (Arg1, 0x02))
        {
            Return (0x5A)
        }
        If (And (Arg1, 0x01))
        {
            Return (0x78)
        }
        Return (0x00)
    }
    Method (UMDM, 4, NotSerialized)
    {
        If (LNot (And (Arg0, 0x02)))
        {
            Return (0x00)
        }
        If (And (Arg1, 0x04))
        {
            Return (Arg3)
        }
        If (And (Arg1, 0x02))
        {
            If (LLessEqual (Arg3, 0x78))
            {
                Return (0xB4)
            }
            Else
            {
                Return (Arg3)
            }
        }
        If (And (Arg2, 0x04))
        {
            If (LLessEqual (Arg3, 0xB4))
            {
                Return (0xF0)
            }
            Else
            {
                Return (Arg3)
            }
        }
        Return (0x00)
    }
    Method (UPIO, 4, NotSerialized)
    {
        If (LNot (And (Arg0, 0x02)))
        {
            If (LEqual (Arg2, 0x02))
            {
                Return (0xF0)
            }
            Else
            {
                Return (0x0384)
            }
        }
        If (And (Arg1, 0x02))
        {
            Return (Arg3)
        }
        If (And (Arg1, 0x01))
        {
            If (LLessEqual (Arg3, 0x78))
            {
                Return (0xB4)
            }
            Else
            {
                Return (Arg3)
            }
        }
        If (LEqual (Arg2, 0x02))
        {
            Return (0xF0)
        }
        Else
        {
            Return (0x0384)
        }
    }
    Method (FDMA, 2, NotSerialized)
    {
        If (LNotEqual (Arg1, 0xFF))
        {
            Return (Or (Arg1, 0x40))
        }
        If (LGreaterEqual (Arg0, 0x03))
        {
            Return (Or (Subtract (Arg0, 0x02), 0x20))
        }
        If (Arg0)
        {
            Return (0x12)
        }
        Return (0x00)
    }
    Method (FPIO, 1, NotSerialized)
    {
        If (LGreaterEqual (Arg0, 0x03))
        {
            Return (Or (Arg0, 0x08))
        }
        If (LEqual (Arg0, 0x01))
        {
            Return (0x01)
        }
        Return (0x00)
    }
    Method (SCMP, 2, NotSerialized)
    {
        Store (SizeOf (Arg0), Local0)
        If (LNotEqual (Local0, SizeOf (Arg1)))
        {
            Return (One)
        }
        Increment (Local0)
        Name (STR1, Buffer (Local0) {})
        Name (STR2, Buffer (Local0) {})
        Store (Arg0, STR1)
        Store (Arg1, STR2)
        Store (Zero, Local1)
        While (LLess (Local1, Local0))
        {
            Store (DerefOf (Index (STR1, Local1)), Local2)
            Store (DerefOf (Index (STR2, Local1)), Local3)
            If (LNotEqual (Local2, Local3))
            {
                Return (One)
            }
            Increment (Local1)
        }
        Return (Zero)
    }
    Name (SPS, 0x00)
    Name (OSIF, 0x00)
    Name (WNTF, 0x00)
    Name (WXPF, 0x00)
    Name (WVIS, 0x00)
    Name (WIN7, 0x00)
    Name (WSPV, 0x00)
    Name (LNUX, 0x00)
    Name (H8DR, 0x00)
    Name (MEMX, 0x00)
    Name (ACST, 0x00)
    Name (FNID, 0x00)
    Name (RRBF, 0x00)
    Name (NBCF, 0x00)
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
        Return (Zero)
    }
}
