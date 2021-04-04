class Project {
  String sId;
  String title;
  String author;
  String domain;
  String membersReq;
  String skills;
  String description;
  String excelSheetLink;
  String wpGrpLink;
  int iV;

  Project(
      {this.sId,
      this.title,
      this.author,
      this.domain,
      this.membersReq,
      this.skills,
      this.description,
      this.excelSheetLink,
      this.wpGrpLink,
      this.iV});

  Project.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    author = json['author'];
    domain = json['domain'];
    membersReq = json['members_req'];
    skills = json['skills'];
    description = json['description'];
    excelSheetLink = json['excel_sheet_link'];
    wpGrpLink = json['wp_grp_link'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['author'] = this.author;
    data['domain'] = this.domain;
    data['members_req'] = this.membersReq;
    data['skills'] = this.skills;
    data['description'] = this.description;
    data['excel_sheet_link'] = this.excelSheetLink;
    data['wp_grp_link'] = this.wpGrpLink;
    data['__v'] = this.iV;
    return data;
  }
}
