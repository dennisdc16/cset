﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace CSETWebCore.DataLayer.Model;

/// <summary>
/// A collection of SECTOR_STANDARD_RECOMMENDATIONS records
/// </summary>
[PrimaryKey("Sector_Id", "Industry_Id", "Organization_Size", "Asset_Value", "Set_Name")]
public partial class SECTOR_STANDARD_RECOMMENDATIONS
{
    [Key]
    public int Sector_Id { get; set; }

    [Key]
    public int Industry_Id { get; set; }

    [Key]
    [StringLength(50)]
    public string Organization_Size { get; set; }

    [Key]
    [StringLength(50)]
    public string Asset_Value { get; set; }

    [Key]
    [StringLength(50)]
    public string Set_Name { get; set; }

    [ForeignKey("Sector_Id")]
    [InverseProperty("SECTOR_STANDARD_RECOMMENDATIONS")]
    public virtual SECTOR Sector { get; set; }

    [ForeignKey("Set_Name")]
    [InverseProperty("SECTOR_STANDARD_RECOMMENDATIONS")]
    public virtual SETS Set_NameNavigation { get; set; }
}