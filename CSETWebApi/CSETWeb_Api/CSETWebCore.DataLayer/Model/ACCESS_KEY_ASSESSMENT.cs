﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace CSETWebCore.DataLayer.Model;

[PrimaryKey("AccessKey", "Assessment_Id")]
public partial class ACCESS_KEY_ASSESSMENT
{
    [Key]
    [StringLength(20)]
    public string AccessKey { get; set; }

    [Key]
    public int Assessment_Id { get; set; }

    [ForeignKey("AccessKey")]
    [InverseProperty("ACCESS_KEY_ASSESSMENT")]
    public virtual ACCESS_KEY AccessKeyNavigation { get; set; }

    [ForeignKey("Assessment_Id")]
    [InverseProperty("ACCESS_KEY_ASSESSMENT")]
    public virtual ASSESSMENTS Assessment { get; set; }
}