---@meta

---@class REPORT : BASE
REPORT = {
  ClassName = "REPORT",
  Title = "",
}

---Create a new REPORT.
---@param Title? string
---@return REPORT
function REPORT:New(Title) end

---Has the REPORT Text?
---@return boolean
function REPORT:HasText() end

---Set indent of a REPORT.
---@param Indent? number
---@return REPORT
function REPORT:SetIndent(Indent) end

---Add a new line to a REPORT.
---@param Text? string
---@return REPORT
function REPORT:Add(Text) end

---Add a new line to a REPORT, but indented. A separator character can be specified to separate the reported lines visually.
---@param Text? string The report text.
---@param Separator? string (optional) The start of each report line can begin with an optional separator character. This can be a "-", or "#", or "*". You're free to choose what you find the best.
---@return REPORT
function REPORT:AddIndent(Text, Separator) end

---Produces the text of the report, taking into account an optional delimiter, which is \n by default.
---@param Delimiter? string (optional) A delimiter text.
---@return string # The report text.
function REPORT:Text(Delimiter) end

---Sets the title of the report.
---@param Title? string The title of the report.
---@return REPORT
function REPORT:SetTitle(Title) end

---Gets the amount of report items contained in the report.
---@return number # Returns the number of report items contained in the report. 0 is returned if no report items are contained in the report. The title is not counted for.
function REPORT:GetCount() end
