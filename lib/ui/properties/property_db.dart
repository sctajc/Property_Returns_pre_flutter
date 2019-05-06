class PropertyDb {
  final String propertyname,
      propertyaddress,
      propertynotes,
      propertyzone,
      propertylegalDescription,
      propertydatepurchased,
      propertylandarea,
      propertyinsurancepolicy,
      propertyinsuranceamount,
      propertyinsurancedate,
      propertyinsurancesource,
      propertymarketvaluation,
      propertymarketvaluationdate,
      propertymarketvaluationsource;

  final int propertyid, displayorder;

  const PropertyDb(
      {this.propertyid,
      this.propertyname,
      this.propertyaddress,
      this.displayorder,
      this.propertynotes,
      this.propertyzone,
      this.propertylandarea,
      this.propertydatepurchased,
      this.propertylegalDescription,
      this.propertyinsurancepolicy,
      this.propertyinsurancedate,
      this.propertyinsuranceamount,
      this.propertyinsurancesource,
      this.propertymarketvaluation,
      this.propertymarketvaluationdate,
      this.propertymarketvaluationsource});
}
