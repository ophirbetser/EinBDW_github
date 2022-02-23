pacman::p_load(
  clipr,
  datapasta
)

# copy last
mtcars
clipr::write_last_clip()

# copy object
clipr::write_clip(iris)

# what is in my clipboard?
clipr::read_clip()
dt <- clipr::read_clip_tbl()


# paste clipboard as text in r script
clipr::write_clip(iris)
datapasta::tribble_paste()
datapasta::dt_paste()

