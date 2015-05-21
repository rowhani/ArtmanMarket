// JScript File

function HighlightSelected(colorcheckboxselected, RowState) 
{ 
    if (colorcheckboxselected.checked) 
        colorcheckboxselected.parentElement.parentElement.style.backgroundColor = '#00FF99'; 
    else 
    { 
        if (RowState == 'Normal') 
            colorcheckboxselected.parentElement.parentElement.style.backgroundColor = 'White'; 
        else 
            colorcheckboxselected.parentElement.parentElement.style.backgroundColor = '#CCCCCC'; 
    } 
}

function ToggleSelectAll(checkedState)
{
    for (var i = 0; i < CheckBoxIDs.length; i++)
    {
        var cb = document.getElementById(CheckBoxIDs[i]);
        if (cb != null)
            {
                cb.checked = checkedState;
                HighlightSelected(cb, CheckBoxStates[i]);
            }      
    }    
}

function CheckForSelectedItems()
{
    checked = false;
    for (var i = 0; i < CheckBoxIDs.length; i++)
    {
        var cb = document.getElementById(CheckBoxIDs[i]);
        if (cb.checked)
        {
            checked = true;
            break;
        }
    }

    if (!checked)
    {
        alert('.هيچ کاربري براي حذف انتخاب نشده است');
        return false;
    }
    else       
        return confirm('آيا واقعا مايل به حذف اين کاربران هستيد؟');      
}