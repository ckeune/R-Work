mat = matrix(runif(36), 6)
rownames(mat) = letters[1:6]
colnames(mat) = letters[1:6]

library(circlize)
circos.par(gap.degree = 1)
chordDiagram(mat, grid.col = 1:6, directional = TRUE, annotationTrack = "grid",
             preAllocateTracks = list(list(track.height = 0.05),
                                      list(track.height = 0.05)))


circos.trackPlotRegion(track.index = 1, panel.fun = function(x, y) {
  xlim = get.cell.meta.data("xlim")
  ylim = get.cell.meta.data("ylim")
  sector.index = get.cell.meta.data("sector.index")
  circos.text(mean(xlim), mean(ylim), sector.index, facing = "inside", niceFacing = TRUE)
}, bg.border = NA)
circos.trackPlotRegion(track.index = 2, panel.fun = function(x, y) {
  circos.axis("bottom", major.tick.percentage = 0.2, labels.cex = 0.4)
}, bg.border = NA)
circos.clear()