CT.Utils = {
  sendToServer: (url, method, data, successCB, failCB, dataType) ->
    $.ajax({
      method: method || 'GET'
      url: url
      data: data
      dataType: dataType || 'json'
    }).done((data) ->
      successCB(data) if $.isFunction(successCB)
    ).fail((response, status) ->
      failCB(response.responseJSON) if $.isFunction(failCB)
    )
}
