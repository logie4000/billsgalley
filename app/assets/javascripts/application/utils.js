/**
 *  * getSelectedTableRows - Returns an array of selected rows in a given HTML table
 *   * 
 *    * @author rmathews
 *     */
function getSelectedTableRows(table_name, column_index) {
  console.log("Scanning table '"+ table_name +"', column '"+ column_index +"' for selected checkboxes...");
  var table = document.getElementById(table_name);
  var selectedRowIds = new Array();

  console.log("Table has " + table.getElementsByTagName("tBody").length + " tBody elements...");

  for (var j = 0; j < table.getElementsByTagName("tBody").length; ++j) {
    var tBody = table.getElementsByTagName("tBody")[j];
    var numRows = tBody.rows.length;
    console.log("Scanning " + numRows + " rows in table child " + j + " for selection...");

    for (var id = 0; id < numRows; ++id) {
      console.log("Scanning row id: " + id + " for selected checkbox...");
      var row = tBody.rows[id];
      var cell = row.cells[column_index];

      console.log("Row " + id + " has " + row.cells.length + " cells");
      console.log("Scanning cell id " + column_index + " for checkbox value...");
      console.log("Cell " + column_index + " has " + cell.getElementsByTagName("input").length + " input elements");

      if (cell.getElementsByTagName("input").length > 0) {
        for (var k = 0; k < cell.getElementsByTagName("input").length; ++k) {
          console.log("Testing cell element [" + k + "] for checkbox type...");

          var checkbox = cell.getElementsByTagName("input")[k];
          if (checkbox.type == 'checkbox') {
            console.log("cell[" + column_index + "].children[" + k + "] is a checkbox.");
            if (checkbox.checked == true) {
              console.log("Row " + id + " is selected.");
              selectedRowIds.push(id);
            } else {
              console.log("Row " + id + " is not selected.");
            }
          } else {
            console.log("cell[" + column_index + "].children[" + k + "] is a not checkbox.");
          }
        }
      }
    }
  }

  return selectedRowIds;
}

/**
 *  * getSelectedDivsByClass - Returns an array of selected div elements in a given HTML document
 *   *
 *    * @author rmathews
 *     */
function getSelectedDivsByClass(div_class, checkbox_id) {
  console.log("Scanning document for divs by class '"+ div_class +"', with checkbox_id '"+ checkbox_id +"' for selected checkboxes...");
  var divs = document.getElementsByClassName(div_class);
  var selectedDivIds = new Array();

  console.log("Document has " + divs.length + " '" + div_class + "' elements...");

  for (var j = 0; j < divs.length; ++j) {
    var div = divs[j];
    var id = div.id;

    console.log("Scanning div " + id + " for selected checkbox with id " + checkbox_id + "...");

    if (div.getElementsByTagName("input").length > 0) {
      console.log("div[" + id + "] has an element with tag of 'input'.");
      var inputs = div.getElementsByTagName("input");
      for (var i = 0; i < inputs.length; ++i) {
        var checkbox = inputs[i];
        if (checkbox.type == 'checkbox') {
          console.log("div[" + id + "].inputs[" + i + "] is a checkbox.");
          if (checkbox.id == checkbox_id) {
            if (checkbox.checked == true) {
              console.log("Div " + id + " is selected.");
              selectedDivIds.push(id);
            } else {
              console.log("Div " + id + " is not selected.");
            }
          } else {
            console.log("div[" + id + "].inputs[" + i + "] has the wrong id value (" + checkbox.id + ").");
          }
        } else {
          console.log("div[" + id + "].inputs[" + i + "] is a not checkbox.");
        }
      }
    } else {
      console.log("No input elements as children of div '" + id + "'.");
    }
  }

  return selectedDivIds;
}

function doGet(url, callback) {
	xmlDoc = new XMLHttpRequest();
	
	xmlDoc.open('GET', url, true);
	xmlDoc.onreadystatechange = function() {
    if (xmlDoc.readyState == 4 && xmlDoc.status == 200) {
      callback(xmlDoc);
    }
 };

  xmlDoc.send();
}

function doPost(url, data, callback) {
	xmlDoc = new XMLHttpRequest();
	
	xmlDoc.open('POST', url, true);
	xmlDoc.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xmlDoc.onreadystatechange = function() {
    if (xmlDoc.readyState == 4 && xmlDoc.status == 200) {
      callback(xmlDoc);
    }
 };

  xmlDoc.send(data);
}

function doPatch(url, data, callback) {
	xmlDoc = new XMLHttpRequest();
	
	xmlDoc.open('PATCH', url, false);
	xmlDoc.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xmlDoc.setRequestHeader("Accept", "text/javascript");
	xmlDoc.onreadystatechange = function() {
		if (callback) {
		    if (xmlDoc.readyState == 4 && xmlDoc.status == 200) {
      			callback(xmlDoc);
      			}
		}
	};

  xmlDoc.send(data);
}

