Path = {}
function Path:new(nodes,radius)
  o = {}
  o.nodes = nodes or {}
  o.radius = radius or 1
  setmetatable(o,self)
  self.__index = self
  return o
end

function Path:addNode(node)
  table.insert(self.nodes,node)
end

function Path:removeNodes()
  self.nodes = {}
end

function Path:setRadius(r)
  self.radius = r
end
