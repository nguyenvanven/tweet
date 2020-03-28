CT.Utils = {
  sendToServer: (url, method, data, successCB, failCB) ->
    $.ajax({
      method: method || 'GET'
      url: url
      data: data
      dataType: 'json'
    }).done((data) ->
      successCB(data) if $.isFunction(successCB)
    ).fail((response, status) ->
      failCB(response.responseJSON) if $.isFunction(failCB)
    )
}
