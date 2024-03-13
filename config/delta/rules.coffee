export default [
  {
    match: {}
    callback:
      url: 'http://resource/.mu/delta'
      method: 'POST'
    options:
      resourceFormat: 'v0.0.1'
      gracePeriod: 2500
      foldEffectiveChanges: true
      ignoreFromSelf: true
  }, {
    match: {}
    callback:
      url: 'http://search/update'
      method: 'POST'
    options:
      resourceFormat: 'v0.0.1'
      gracePeriod: 3000
      foldEffectiveChanges: true
      ignoreFromSelf: true
  }
]
