local kap = import "lib/kapitan.libjsonnet";
local inv = kap.inventory();

local apiversion    = inv.parameters.apiversion;
local image         = inv.parameters.image;
local target_name   = inv.parameters.target_name;
local apiport       = inv.parameters.apiport;



{
  kind: {  
          kind: 'Cluster',
          apiVersion: apiversion,
          name: target_name,  
          nodes: 
                  [
                    {
                      role: 'control-plane',
                      image: image,
                    },
                    {
                      role: 'control-plane',
                    },
                    {
                      role: 'worker',
                    },
                    {
                      role: 'worker',
                    },
                  ],
        }
}
