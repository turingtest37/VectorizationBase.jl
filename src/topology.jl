

const TOPOLOGY = Hwloc.topology_load();
const CACHE = TOPOLOGY.children[1].children[1];
const COUNTS = Hwloc.histmap(TOPOLOGY);
const CACHE_COUNT = (
    COUNTS[:L1Cache],
    COUNTS[:L2Cache],
    COUNTS[:L3Cache]
)
const NUM_CORES = COUNTS[:Core]

L1,L2,L3 = CACHE_COUNT[1:3] .> 0

# The following is amenable to simplification by metaprogramming
attr = L3 ? CACHE.children[1].children[1].attr : CACHE.children[1].attr
const L₁CACHE = (
    size = L1 ? attr.size : nothing,
    depth = L1 ? attr.depth : nothing,
    linesize = L1 ? attr.linesize : nothing,
    associativity = L1 ? attr.associativity : nothing,
    type = L1 ? attr.type_ : nothing
)
attr = L3 ? CACHE.children[1].attr : CACHE.attr
const L₂CACHE = (
    size = L2 ? attr.size : nothing,
    depth = L2 ? attr.depth : nothing,
    linesize = L2 ? attr.linesize : nothing,
    associativity = L2 ? attr.associativity : nothing,
    type = L2 ? attr.type_ : nothing
)
attr = L3 ? CACHE.attr : nothing
const L₃CACHE = (
    size = L3 ? attr.size : nothing,
    depth = L3 ? attr.depth : nothing,
    linesize = L3 ? attr.linesize : nothing,
    associativity = L3 ? attr.associativity : nothing,
    type = L3 ? attr.type_ : nothing
)
"""
L₁, L₂, L₃ cache size
"""
const CACHE_SIZE = (
    L₁CACHE.size,
    L₂CACHE.size,
    L₃CACHE.size
)
# const CACHE_NEST_COUNT = (
#     length(CACHE.children[1].children),
#     length(CACHE.children),
#     length(TOPOLOGY.children[1].children)
# )
