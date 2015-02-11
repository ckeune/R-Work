library("migest")
demo("cfplot_reg", "migest")

dev.copy2pdf(file = "cfplot_reg.pdf", height=10, width=10)


install.packages("circlize")



library("circlize")
 
for(i in 1:9) {
  factors = 1:10
  par(mar = c(0.5, 0.5, 0.5, 0.5))
  
  
  circos.par(cell.padding = c(0, 0, 0, 0))
  circos.initialize(factors, xlim = c(0, 1))
  circos.trackPlotRegion(ylim = c(0, 1), track.height = 0.05,
                         bg.col = rand_color(10), bg.border = NA,
                         
                        panel.fun = function(x, y) {
                           #select details of current sector
                           name = get.cell.meta.data("sector.index")
                           i = get.cell.meta.data("sector.numeric.index")
                           xlim = get.cell.meta.data("xlim")
                           ylim = get.cell.meta.data("ylim")
                           
                           #plot country labels
                           circos.text(x=mean(xlim), y=2.2, labels=name, facing = "bending", cex=0.8)
#                            
#                            #plot main sector
#                            circos.rect(xleft=xlim[1], ybottom=ylim[1], xright=xlim[2], ytop=ylim[2], 
#                                        col = df1$rcol[i], border=df1$rcol[i])
#                            
#                            #blank in part of main sector
#                            circos.rect(xleft=xlim[1], ybottom=ylim[1], xright=xlim[2]-rowSums(m)[i], ytop=ylim[1]+0.3, 
#                                        col = "white", border = "white")
#                            
#                            #white line all the way around
#                            circos.rect(xleft=xlim[1], ybottom=0.3, xright=xlim[2], ytop=0.32, col = "white", border = "white")
                           
                           #plot axis
#                            circos.axis(labels.cex=0.8, direction = "outside", major.at=seq(0,floor(df1$xmax)[i]), minor.ticks=1,
#                                        labels.away.percentage = 0.15)
                         })
  
  
  for(i in 1:20) {
    se = sample(1:10, 2)
    circos.link(se[1], runif(2), se[2], runif(2),
                col = rand_color(1, transparency = 0.4))
    
  }  
  circos.clear()
}







panel.fun = function(x, y) {
  name = get.cell.meta.data("sector.index")
  i = get.cell.meta.data("sector.numeric.index")
  xlim = get.cell.meta.data("xlim")
  ylim = get.cell.meta.data("ylim")
  circos.text(x=mean(xlim), y=2.2, labels=name, direction = "arc")
  circos.rect(xleft=xlim[1], ybottom=ylim[1], xright=xlim[2], ytop=ylim[2],
              col = df1\$rcol[i], border=df1\$rcol[i])
  circos.rect(xleft=xlim[1], ybottom=ylim[1], xright=xlim[2]-rowSums(m)[i],
              ytop=ylim[1]+0.3, col = "white", border = "white")
  circos.rect(xleft=xlim[1], ybottom=0.3, xright=xlim[2], ytop=0.32,
              col = "white", border = "white")
  circos.axis(labels.cex=0.8, direction = "outside",
              major.at=seq(0,floor(df1\$xmax)[i]), minor.ticks=1,
              labels.away.percentage = 0.15)
}
)