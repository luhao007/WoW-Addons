-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

local LibTSMUtil = select(2, ...).LibTSMUtil
local DatabaseSchema = LibTSMUtil:DefineClassType("DatabaseSchema")
local DatabaseTable = LibTSMUtil:IncludeClassType("DatabaseTable")
local ObjectPool = LibTSMUtil:IncludeClassType("ObjectPool")
local EnumType = LibTSMUtil:Include("BaseType.EnumType")
local private = {
	objectPool = ObjectPool.New("DATABASE_SCHEMAS", DatabaseSchema, 1),
}



-- ============================================================================
-- Static Class Functions
-- ============================================================================

---Gets a new DB schema object.
---@param name string The name of the schema
---@return DatabaseSchema @The schema object
function DatabaseSchema.__static.Get(name)
	local schema = private.objectPool:Get()
	schema:_Acquire(name)
	return schema
end



-- ============================================================================
-- Class Method Methods
-- ============================================================================

function DatabaseSchema.__private:__init()
	self._name = nil
	self._fieldList = {}
	self._fieldTypeLookup = {}
	self._fieldTypeEnumType = {}
	self._isIndex = {}
	self._isUnique = {}
	self._smartMapLookup = {}
	self._smartMapInputLookup = {}
	self._trigramIndexField = nil
end

function DatabaseSchema.__private:_Acquire(name)
	assert(type(name) == "string")
	self._name = name
end

function DatabaseSchema.__private:_Release()
	self._name = nil
	wipe(self._fieldList)
	wipe(self._fieldTypeLookup)
	wipe(self._fieldTypeEnumType)
	wipe(self._isIndex)
	wipe(self._isUnique)
	wipe(self._smartMapLookup)
	wipe(self._smartMapInputLookup)
	self._trigramIndexField = nil
end



-- ============================================================================
-- Public Class Method
-- ============================================================================

---Adds a string field to the DB schema.
---@param fieldName string The name of the field
---@return DatabaseSchema
function DatabaseSchema:AddStringField(fieldName)
	self:_AddField("string", fieldName)
	return self
end

---Adds a number field to the DB schema.
---@param fieldName string The name of the field
---@return DatabaseSchema
function DatabaseSchema:AddNumberField(fieldName)
	self:_AddField("number", fieldName)
	return self
end

---Adds a boolean field to the DB schema.
---@param fieldName string The name of the field
---@return DatabaseSchema
function DatabaseSchema:AddBooleanField(fieldName)
	self:_AddField("boolean", fieldName)
	return self
end

---Adds an enum type field to the DB schema.
---@param fieldName string The name of the field
---@param enumType EnumObject The enum type
---@return DatabaseSchema
function DatabaseSchema:AddEnumField(fieldName, enumType)
	assert(EnumType.IsType(enumType))
	self:_AddField("ENUM", fieldName, nil, enumType)
	return self
end

---Adds a string field with a unique index to the DB schema.
---@param fieldName string The name of the field
---@return DatabaseSchema
function DatabaseSchema:AddUniqueStringField(fieldName)
	self:_AddField("string", fieldName, true)
	return self
end

---Adds a number field with a unique index to the DB schema.
---@param fieldName string The name of the field
---@return DatabaseSchema
function DatabaseSchema:AddUniqueNumberField(fieldName)
	self:_AddField("number", fieldName, true)
	return self
end

---Adds a string list field to the DB schema.
---@param fieldName string The name of the field
---@return DatabaseSchema
function DatabaseSchema:AddStringListField(fieldName)
	self:_AddField("STRING_LIST", fieldName)
	return self
end

---Adds a number list field to the DB schema.
---@param fieldName string The name of the field
---@return DatabaseSchema
function DatabaseSchema:AddNumberListField(fieldName)
	self:_AddField("NUMBER_LIST", fieldName)
	return self
end

---Adds a smart map field to the DB schema.
---@param fieldName string The name of the field
---@param map SmartMapObject The smart map object
---@param inputFieldName string The name of the field which is used as an input to the smart map
---@return DatabaseSchema
function DatabaseSchema:AddSmartMapField(fieldName, map, inputFieldName)
	assert(self._fieldTypeLookup[inputFieldName] == map:GetKeyType())
	local fieldType = map:GetValueType()
	assert(fieldType == "string" or fieldType == "number" or fieldType == "boolean")
	self:_AddField(fieldType, fieldName)
	self._smartMapLookup[fieldName] = map
	self._smartMapInputLookup[fieldName] = inputFieldName
	return self
end

---Adds an index which speeds up querying for the field.
---@param fieldName string The name of the field to index
---@return DatabaseSchema
function DatabaseSchema:AddIndex(fieldName)
	local fieldType = self._fieldTypeLookup[fieldName]
	assert(fieldType and fieldType ~= "STRING_LIST" and fieldType ~= "NUMBER_LIST" and not self._isIndex[fieldName])
	self._isIndex[fieldName] = true
	return self
end

---Adds a trigram index which speeds up text searching.
---@param fieldName string The name of the field to index
---@return DatabaseSchema
function DatabaseSchema:AddTrigramIndex(fieldName)
	local fieldType = self._fieldTypeLookup[fieldName]
	assert(fieldType and fieldType ~= "STRING_LIST" and fieldType ~= "NUMBER_LIST" and not self._trigramIndexField)
	self._trigramIndexField = fieldName
	return self
end

---Commits the schema and creates a DB table.
---@return DatabaseTable
function DatabaseSchema:Commit()
	local db = DatabaseTable.Create(self)
	self:_Release()
	private.objectPool:Recycle(self)
	return db
end



-- ============================================================================
-- Private Class Method
-- ============================================================================

function DatabaseSchema.__private:_AddField(fieldType, fieldName, isUnique, fieldTypeEnumType)
	assert(type(fieldName) == "string" and strsub(fieldName, 1, 1) ~= "_")
	assert(not self._fieldTypeLookup[fieldName])
	tinsert(self._fieldList, fieldName)
	self._fieldTypeLookup[fieldName] = fieldType
	self._fieldTypeEnumType[fieldName] = fieldTypeEnumType
	if isUnique then
		self._isUnique[fieldName] = true
	end
end

---@private
function DatabaseSchema:_GetName()
	return self._name
end

---@private
function DatabaseSchema:_FieldIterator()
	return private.FieldIterator, self, 0
end


-- ============================================================================
-- Private Helper Functions
-- ============================================================================

function private.FieldIterator(schema, index)
	index = index + 1
	if index > #schema._fieldList then
		return
	end
	local fieldName = schema._fieldList[index]
	return index, fieldName, schema._fieldTypeLookup[fieldName], schema._isIndex[fieldName], schema._isUnique[fieldName], schema._trigramIndexField == fieldName, schema._smartMapLookup[fieldName], schema._smartMapInputLookup[fieldName], schema._fieldTypeEnumType[fieldName]
end
